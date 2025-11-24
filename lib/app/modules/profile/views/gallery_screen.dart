

import 'dart:io';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/utils/image_picker.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoItem {
  final String? url;
  final File? file;
  final bool isDeleted;

  PhotoItem({this.url, this.file, this.isDeleted = false});

  PhotoItem copyWith({String? url, File? file, bool? isDeleted}) {
    return PhotoItem(
      url: url ?? this.url,
      file: file ?? this.file,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  bool get isEmpty => url == null && file == null;
  bool get hasContent => !isEmpty && !isDeleted;
}

class GalleryScreen extends StatelessWidget {
  GalleryScreen({super.key});

  final userController = Get.find<UserController>();
  final RxList<PhotoItem> photos = <PhotoItem>[].obs;

  @override
  Widget build(BuildContext context) {
    // Initialize photos from user data
    if (photos.isEmpty) {
      final userPhotos = userController.user.value?.photos ?? [];
      photos.value = List.generate(6, (index) {
        if (index < userPhotos.length) {
          return PhotoItem(url: userPhotos[index]);
        }
        return PhotoItem();
      });
    }

    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "Edit pictures",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Edit your profile pictures",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(() {
                return Expanded(
                  child: GridView.builder(
                    itemCount: photos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final photo = photos[index];
                      final hasContent = photo.hasContent;

                      return InkWell(
                        onTap: () async {
                          if (!hasContent) {
                            await _selectImage(index);
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: photo.isDeleted
                                      ? Colors.red.withOpacity(0.5)
                                      : Colors.grey,
                                ),
                                image: _getImageDecoration(photo),
                              ),
                              child: !hasContent
                                  ? Center(
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  : null,
                            ),
                            if (hasContent)
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Row(
                                  children: [
                                    _buildActionButton(
                                      icon: Icons.edit,
                                      color: Colors.blue,
                                      onTap: () => _replaceImage(index),
                                    ),
                                    SizedBox(width: 5),
                                    _buildActionButton(
                                      icon: Icons.delete,
                                      color: Colors.red,
                                      onTap: () => _deleteImage(index),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 10),
              CustomButton(
                ontap: () async {
                  if (userController.isloading.value) return;
                  await _saveChanges();
                },
                isLoading: userController.isloading,
                child: Text(
                  "Save",
                  style: GoogleFonts.figtree(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }

  DecorationImage? _getImageDecoration(PhotoItem photo) {
    if (!photo.hasContent) return null;

    if (photo.file != null) {
      return DecorationImage(
        image: FileImage(photo.file!),
        fit: BoxFit.cover,
        colorFilter: photo.isDeleted
            ? ColorFilter.mode(Colors.grey, BlendMode.saturation)
            : null,
      );
    } else if (photo.url != null) {
      return DecorationImage(
        image: NetworkImage(photo.url!),
        fit: BoxFit.cover,
        colorFilter: photo.isDeleted
            ? ColorFilter.mode(Colors.grey, BlendMode.saturation)
            : null,
      );
    }
    return null;
  }

  Future<void> _selectImage(int index) async {
    final image = await pickImage();
    if (image == null) return;

    photos[index] = PhotoItem(file: image);
    photos.refresh();
  }

  Future<void> _replaceImage(int index) async {
    final image = await pickImage();
    if (image == null) return;

    photos[index] = PhotoItem(file: image);
    photos.refresh();
  }

  void _deleteImage(int index) {
    final photo = photos[index];
    if (photo.url != null) {
      // Mark existing photo as deleted
      photos[index] = photo.copyWith(isDeleted: true);
    } else {
      // Remove new photo
      photos[index] = PhotoItem();
    }
    photos.refresh();
  }

  Future<void> _saveChanges() async {
    // Get all photos that have content and are not deleted
    final activePhotos = photos.where((p) => p.hasContent).toList();

    if (activePhotos.length < 2) {
      CustomSnackbar.showErrorToast("Please add at least 2 pictures");
      return;
    }

    // Prepare data for backend
    final newFiles = photos
        .where((p) => p.file != null && !p.isDeleted)
        .map((p) => p.file!)
        .toList();

    final existingUrls = photos
        .where((p) => p.url != null && !p.isDeleted)
        .map((p) => p.url!)
        .toList();

    final deletedUrls = photos
        .where((p) => p.url != null && p.isDeleted)
        .map((p) => p.url!)
        .toList();

    print("newFiles: $newFiles");
    print("existingUrls: $existingUrls");
    print("deletedUrls: $deletedUrls");

    // Call the controller method with categorized data
    // await userController.updateGallery(
    //   newFiles: newFiles,
    //   existingUrls: existingUrls,
    //   deletedUrls: deletedUrls,
    // );
  }
}

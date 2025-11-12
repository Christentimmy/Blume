import 'dart:io';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/utils/image_picker.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddPicturesScreen extends StatelessWidget {
  final VoidCallback? whatNext;
  AddPicturesScreen({super.key, this.whatNext});

  final userController = Get.find<UserController>();
  final RxList<File?> images = List<File?>.filled(6, null).obs;

  Future<void> selectImage(int index) async {
    final image = await pickImage();
    if (image == null) return;
    images[index] = image;
    images.refresh();
  }

  @override
  Widget build(BuildContext context) {
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
                  // const Spacer(),
                  // InkWell(
                  //   onTap: () => Get.toNamed(AppRoutes.lifestyle),
                  //   child: Text(
                  //     "Skip",
                  //     style: GoogleFonts.figtree(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //       color: AppColors.primaryColor,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "Add some pictures",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Add 2 to 4 pictures to make your profile stand out",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(() {
                return Expanded(
                  child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final image = images[index];
                      return InkWell(
                        onTap: () async {
                          await selectImage(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            image: image != null
                                ? DecorationImage(
                                    image: FileImage(image),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: image == null
                              ? Center(
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.primaryColor,
                                  ),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                );
              }),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: 6,
                  count: 7,
                  effect: const WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomButton(
                ontap: () async {
                  if (userController.isloading.value) return;
                  final selectedImages = images
                      .where((img) => img != null)
                      .toList();
                  if (selectedImages.length < 2) {
                    CustomSnackbar.showErrorToast(
                      "Please add atleast 2 pictures",
                    );
                    return;
                  }
                  await userController.addPhotoToGallery(
                    imageFiles: selectedImages.cast<File>(),
                    whatNext: whatNext,
                  );
                },
                isLoading: userController.isloading,
                child: Text(
                  "Next",
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
}

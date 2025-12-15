import 'dart:io';

import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/utils/image_picker.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final RxList<File?> images = List<File?>.filled(3, null).obs;

  void addImages({required int index}) async {
    final im = await pickImage();
    if (im == null) return;
    if (index < 0 || index >= images.length) return;
    images[index] = im;
  }

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selfie-Verification',
          style: GoogleFonts.figtree(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            GestureDetector(
              onTap: () => addImages(index: 0),
              child: Obx(() {
                final file = images[0];
                return Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.primaryColor, width: 1),
                    image: file != null
                        ? DecorationImage(
                            image: FileImage(file),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: file == null
                      ? Icon(Icons.camera, color: AppColors.primaryColor)
                      : const SizedBox.shrink(),
                );
              }),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => addImages(index: 1),
              child: Obx(() {
                final file = images[1];
                return Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.primaryColor, width: 1),
                    image: file != null
                        ? DecorationImage(
                            image: FileImage(file),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: file == null
                      ? Icon(Icons.camera, color: AppColors.primaryColor)
                      : const SizedBox.shrink(),
                );
              }),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => addImages(index: 2),
              child: Obx(() {
                final file = images[2];
                return Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.primaryColor, width: 1),
                    image: file != null
                        ? DecorationImage(
                            image: FileImage(file),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: file == null
                      ? Icon(Icons.camera, color: AppColors.primaryColor)
                      : const SizedBox.shrink(),
                );
              }),
            ),
            SizedBox(height: 20),
            CustomButton(
              ontap: () async {
                if (images.isEmpty) {
                  CustomSnackbar.showErrorToast(
                    "Upload all 3 required pictures",
                  );
                  return;
                }
                if (images.length > 3 || images.length < 3) {
                  CustomSnackbar.showErrorToast("Only Upload 3 images");
                  return;
                }
                await userController.applyVerification(imageFiles: images );
              },
              isLoading: userController.isloading,
              child: Text(
                "Submit",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateGenderScreen extends StatelessWidget {
  final VoidCallback? whatNext;
  UpdateGenderScreen({super.key, this.whatNext});

  final Rxn<String> selectedGender = Rxn<String>();
  final Rx<bool> showGender = false.obs;
  final userController = Get.find<UserController>();

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
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "Gender",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Obx(
                () => CustomButton(
                  bgColor: selectedGender.value == "male"
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  border: Border.all(
                    color: selectedGender.value == "male"
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                  ),
                  ontap: () {
                    if (selectedGender.value == "male") {
                      selectedGender.value = null;
                    } else {
                      selectedGender.value = "male";
                    }
                  },
                  isLoading: false.obs,
                  child: Text(
                    "Male",
                    style: GoogleFonts.figtree(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: selectedGender.value == "male"
                          ? Colors.white
                          : Get.theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Obx(
                () => CustomButton(
                  bgColor: selectedGender.value == "female"
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  border: Border.all(
                    color: selectedGender.value == "female"
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                  ),
                  ontap: () {
                    if (selectedGender.value == "female") {
                      selectedGender.value = null;
                    } else {
                      selectedGender.value = "female";
                    }
                  },
                  isLoading: false.obs,
                  child: Text(
                    "Female",
                    style: GoogleFonts.figtree(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: selectedGender.value == "female"
                          ? Colors.white
                          : Get.theme.primaryColor,
                    ),
                  ),
                ),
              ),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Checkbox(
                      value: showGender.value,
                      onChanged: (value) {
                        showGender.value = value!;
                      },
                      checkColor: Colors.white,
                      activeColor: AppColors.primaryColor,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  Text(
                    "show my gender on my profile",
                    style: GoogleFonts.figtree(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              CustomButton(
                ontap: () async {
                  if (selectedGender.value == null) {
                    CustomSnackbar.showErrorToast("Please select a gender");
                    return;
                  }
                  await userController.updateGender(
                    gender: selectedGender.value!,
                    showGender: showGender.value,
                    whatNext: whatNext,
                  );
                },
                isLoading: userController.isloading,
                child: Text(
                  "Next",
                  style: GoogleFonts.figtree(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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

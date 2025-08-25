import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.33),
              Text(
                "BLUME",
                style: GoogleFonts.figtree(
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryColor,
                ),
              ),
              const Spacer(),
              CustomButton(
                ontap: () {},
                isLoading: false.obs,
                child: Text(
                  "Create account",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),

              CustomButton(
                ontap: () => Get.toNamed(AppRoutes.login),
                bgColor: Get.isDarkMode
                    ? AppColors.darkButtonColor
                    : AppColors.lightButtonColor,
                isLoading: false.obs,
                child: Text(
                  "Login",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              Text(
                "Privacy Policy",
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: Get.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/utils/validator.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: Get.height * 0.11),
              Center(
                child: Text(
                  "BLUME",
                  style: GoogleFonts.figtree(
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Welcome back",
                  style: Get.textTheme.bodyLarge?.copyWith(fontSize: 24),
                ),
              ),
              Center(
                child: Text(
                  "Login to your account",
                  style: Get.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: Get.height * 0.1),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3.0,
                  vertical: 2,
                ),
                child: Text(
                  "Email",
                  style: GoogleFonts.figtree(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              CustomTextField(
                hintText: "Enter your email",
                validator: validateEmail,
                prefixIcon: Icons.email,
                prefixIconColor: AppColors.primaryColor,
              ),

              SizedBox(height: Get.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3.0,
                  vertical: 2,
                ),
                child: Text(
                  "Password",
                  style: GoogleFonts.figtree(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              CustomTextField(
                hintText: "Enter your password",
                prefixIcon: Icons.lock,
                prefixIconColor: AppColors.primaryColor,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.05),
              CustomButton(
                ontap: () => Get.toNamed(AppRoutes.bottomNavigation),
                isLoading: false.obs,
                child: Text(
                  "Login",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.signup),
                    child: Text(
                      "Sign Up",
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:blume/app/controller/auth_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  ResetPasswordScreen({super.key, required this.email});

  final formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: GoogleFonts.figtree(
            color: Get.theme.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.1),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 2,
                      ),
                      child: Text(
                        "New Password",
                        style: GoogleFonts.figtree(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Enter new password",
                      prefixIcon: Icons.lock,
                      prefixIconColor: AppColors.primaryColor,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 2,
                      ),
                      child: Text(
                        "Confirm Password",
                        style: GoogleFonts.figtree(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    CustomTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm new password",
                      prefixIcon: Icons.lock,
                      prefixIconColor: AppColors.primaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "";
                        }
                        if (value != passwordController.text) {
                          return "";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              CustomButton(
                ontap: () async {
                  if (!formKey.currentState!.validate()) return;
                  await authController.loginUser(
                    identifier: email,
                    password: passwordController.text,
                  );
                },
                isLoading: authController.isloading,
                child: Text(
                  "Reset Password",
                  style: Get.textTheme.bodyMedium?.copyWith(
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

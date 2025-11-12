import 'package:blume/app/controller/auth_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/utils/validator.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: Get.height * 0.1),
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
                  "Welcome to Blume",
                  style: Get.textTheme.bodyLarge?.copyWith(fontSize: 24),
                ),
              ),
              Center(
                child: Text(
                  "Sign up to continue",
                  style: Get.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: Get.height * 0.06),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      controller: emailController,
                    ),

                    SizedBox(height: Get.height * 0.025),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                        vertical: 2,
                      ),
                      child: Text(
                        "Phone Number",
                        style: GoogleFonts.figtree(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    CustomTextField(
                      hintText: "Enter your phone number",
                      prefixIcon: Icons.phone,
                      prefixIconColor: AppColors.primaryColor,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),

                    SizedBox(height: Get.height * 0.025),
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
                      controller: passwordController,
                    ),
                  ],
                ),
              ),

              SizedBox(height: Get.height * 0.05),
              CustomButton(
                ontap: () async {
                  if (!formKey.currentState!.validate()) return;
                  await authController.register(
                    email: emailController.text,
                    phone: phoneController.text,
                    password: passwordController.text,
                  );
                },
                isLoading: authController.isloading,
                child: Text(
                  "Sign Up",
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
                    "Already have an account? ",
                    style: Get.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.login),
                    child: Text(
                      "Login",
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

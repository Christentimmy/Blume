import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateNameScreen extends StatelessWidget {
  final VoidCallback? whatNext;
  UpdateNameScreen({super.key, this.whatNext});

  final userController = Get.find<UserController>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

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
                "First name",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "this is how your name appears on your profile",
                // textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: CustomTextField(
                  controller: nameController,
                  hintText: "Enter your full name",
                  prefixIcon: Icons.person,
                  prefixIconColor: AppColors.primaryColor,
                  showError: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your full name";
                    }
                    if (value.split(" ").length < 2) {
                      return "Please enter your full name";
                    }
                    if (value.split(" ")[1].length < 2) {
                      return "Please enter your full name";
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(),
              CustomButton(
                ontap: () async {
                  if (!formKey.currentState!.validate()) return;
                  await userController.updateName(
                    name: nameController.text,
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

import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/resources/colors.dart';
// import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BioScreen extends StatelessWidget {
  final VoidCallback? whatNext;
  BioScreen({super.key, this.whatNext});

  final userController = Get.find<UserController>();
  final bioController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                "Bio",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Add a short bio to let your matches know you better.",
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
                  controller: bioController,
                  label: "Enter your bio",
                  prefixIcon: Icons.person,
                  prefixIconColor: AppColors.primaryColor,
                  minLines: 3,
                  maxLines: 4,
                  maxLength: 300,
                ),
              ),
              const Spacer(),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: 2,
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
                  if (!formKey.currentState!.validate()) return;
                  await userController.updateBio(bio: bioController.text);
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

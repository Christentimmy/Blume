import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.addPictures),
                    child: Text(
                      "Skip",
                      style: GoogleFonts.figtree(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Center(
                child: Text(
                  "Congratulations\nYou have a match!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.figtree(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              Center(
                child: SizedBox(
                  height: Get.height * 0.4,
                  width: Get.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.rotate(
                        angle: 0.25,
                        child: Container(
                          height: Get.height * 0.34,
                          width: Get.width * 0.42,
                          margin: EdgeInsets.only(
                            left: Get.width * 0.15,
                            bottom: Get.height * 0.1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("assets/images/plm.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: -0.2,
                        child: Container(
                          height: Get.height * 0.34,
                          width: Get.width * 0.42,
                          margin: EdgeInsets.only(
                            top: Get.height * 0.07,
                            right: Get.width * 0.2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("assets/images/frm.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                ontap: () {
                  // Get.toNamed(AppRoutes.signup);
                },
                isLoading: false.obs,
                child: Text(
                  "Send a text",
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
                  "Keep swiping",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                  ),
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

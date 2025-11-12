import 'package:blume/app/controller/location_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SetLocationScreen extends StatelessWidget {
  final VoidCallback? whatNext;
  SetLocationScreen({super.key, this.whatNext});

  final locationController = Get.find<LocationController>();

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
                "Set your Location",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Allow location permission to use the app",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Get.isDarkMode
                      ? AppColors.darkButtonColor
                      : AppColors.lightButtonColor,
                  child: Icon(
                    Icons.location_on,
                    size: 40,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              Spacer(),
              CustomButton(
                ontap: () async {
                  await locationController.getCurrentCity(nextScreen: whatNext);
                },
                isLoading: locationController.isloading,
                child: Text(
                  "Location",
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

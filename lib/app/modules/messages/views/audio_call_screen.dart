import 'package:blume/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioCallScreen extends StatelessWidget {
  const AudioCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          "Outgoing call",
          style: GoogleFonts.figtree(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Get.theme.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.07),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/frm.png"),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Center(
                child: Text(
                  "Jessica Baker",
                  style: GoogleFonts.figtree(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Calling",
                  style: GoogleFonts.figtree(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: Get.width * 0.1,
                    backgroundColor: Get.isDarkMode
                        ? AppColors.darkButtonColor
                        : AppColors.lightButtonColor,
                    child: Icon(Icons.volume_up),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: Get.width * 0.1,
                    backgroundColor: Get.isDarkMode
                        ? AppColors.darkButtonColor
                        : AppColors.lightButtonColor,
                    child: Icon(Icons.video_call),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: Get.width * 0.1,
                    backgroundColor: Get.isDarkMode
                        ? AppColors.darkButtonColor
                        : AppColors.lightButtonColor,
                    child: Icon(Icons.message),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: Get.width * 0.1,
                    backgroundColor: Get.isDarkMode
                        ? AppColors.darkButtonColor
                        : AppColors.lightButtonColor,
                    child: Icon(Icons.mic),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: Get.width * 0.1,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.call),
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                    radius: Get.width * 0.1,
                    backgroundColor: Get.isDarkMode
                        ? AppColors.darkButtonColor
                        : AppColors.lightButtonColor,
                    child: Icon(Icons.keyboard_rounded),
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

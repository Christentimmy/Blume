
import 'package:blume/app/modules/profile/widgets/list_tile_widget.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InterestScreen extends StatelessWidget {
  InterestScreen({super.key});

  final List<String> lifestyle = [
    "Volunteering",
    "Sustainability",
    "Spirituality",
    "Minimalism",
    "Mindfulness",
    "Volunteering",
  ];

  final List<String> hobbies = [
    "Reading",
    "Traveling",
    "Cooking",
    "Painting",
    "Gardening",
    "Photography",
    "Music",
    "Dancing",
    "Swimming",
    "Yoga",
  ];



  final RxInt selectedLifestyleOption = (-1).obs;
  final RxInt selectedHobbiesOption = (-1).obs;

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
              Text(
                "Interests",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "More of what you like",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              Expanded(
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle(title: "Lifestyle & Values"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: lifestyle,
                      selectedOption: selectedLifestyleOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Learning & Hobbies"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: hobbies,
                      selectedOption: selectedHobbiesOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    // buildTitle(title: "Do you workout?"),
                    // SizedBox(height: Get.height * 0.01),
                    // buildOptions(
                    //   options: workout,
                    //   selectedOption: selectedWorkoutOption,
                    // ),
                    // SizedBox(height: Get.height * 0.02),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: 5,
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
                ontap: () => Get.toNamed(AppRoutes.addPictures),
                isLoading: false.obs,
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

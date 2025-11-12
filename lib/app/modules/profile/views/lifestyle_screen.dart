import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/modules/profile/widgets/list_tile_widget.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LifeStyleScreen extends StatelessWidget {
  final VoidCallback? whatNext;
  LifeStyleScreen({super.key, this.whatNext});

  final List<String> drinks = [
    "I don’t drink",
    "A few times a year",
    "Only on special occasions",
    "Daily",
    "Weekends mostly",
    "A few times a week",
  ];

  final List<String> smoke = [
    "I don’t smoke",
    "Sometimes",
    "Only socially",
    "Vape only",
    "Daily smoker",
    "Trying to quit",
  ];

  final List<String> workout = ["Everyday", "Sometimes", "Often", "Never"];

  final List<String> pet = [
    "Dogs",
    "Cats",
    "Reptile",
    "Rabits",
    "Amphibian",
    "Fish",
    "Others",
    "Allergic but still love them",
    "I have a small zoo",
    "No, I hate animals",
    "No, but I love animals",
  ];

  final RxInt selectedDrinkOption = (-1).obs;
  final RxInt selectedSmokeOption = (-1).obs;
  final RxInt selectedWorkoutOption = (-1).obs;
  final RxInt selectedPetOption = (-1).obs;

  final userController = Get.find<UserController>();

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
                    onTap: () => Get.toNamed(AppRoutes.religionWork),
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
                "Lifestyle",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "match your habits with theirs",
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
                    buildTitle(title: "How often do you drink?"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: drinks,
                      selectedOption: selectedDrinkOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "How often do you smoke?"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: smoke,
                      selectedOption: selectedSmokeOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Do you workout?"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: workout,
                      selectedOption: selectedWorkoutOption,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Do you have pets?"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: pet,
                      selectedOption: selectedPetOption,
                    ),
                    SizedBox(height: Get.height * 0.02),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: 3,
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
                  String smoking = smoke[selectedSmokeOption.value];
                  String drinking = drinks[selectedDrinkOption.value];
                  String work = workout[selectedWorkoutOption.value];
                  await userController.updateLifestyle(
                    smoking: smoking,
                    drinking: drinking,
                    workout: work,
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

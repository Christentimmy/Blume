import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LifeStyleScreen extends StatelessWidget {
  LifeStyleScreen({super.key});

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

  final List<String> workout = [
    "I don’t workout",
    "A few times a year",
    "Only on special occasions",
    "Daily",
    "Weekends mostly",
    "A few times a week",
  ];

  final RxInt selectedDrinkOption = (-1).obs;
  final RxInt selectedSmokeOption = (-1).obs;
  final RxInt selectedWorkoutOption = (-1).obs;

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
                ontap: () => Get.toNamed(AppRoutes.updateDob),
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

  Wrap buildOptions({
    required List<String> options,
    required RxInt selectedOption,
  }) {
    return Wrap(
      runSpacing: 10,
      children: List.generate(
        options.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Obx(
            () => InkWell(
              onTap: () => selectedOption.value = index,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: selectedOption.value == index
                      ? Border.all(color: AppColors.primaryColor)
                      : Border.all(color: Colors.grey),
                  color: Colors.transparent,
                ),
                child: Text(
                  options[index],
                  style: GoogleFonts.figtree(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: selectedOption.value == index
                        ? AppColors.primaryColor
                        : Get.theme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildTitle({required String title}) {
    return Text(
      title,
      style: GoogleFonts.figtree(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}

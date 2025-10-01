import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReligionWorkScreen extends StatelessWidget {
  ReligionWorkScreen({super.key});

  final List<String> religion = [
    "Agnostic",
    "Atheist",
    "Buddhist",
    "Catholic"
        "Christian (non-Catholic)",
    "Hindu",
    "Jewish",
    "Muslim",
    "Spiritual but not religious",
    "Other",
    "Prefer not to say",
  ];

  final List<String> education = [
    "High school diploma or GED",
    "Some college",
    "Associate's degree"
        "Bachelor's degree",
    "Master's degree",
    "Doctorate (PhD, MD, JD, etc.)",
    "Trade/technical/vocational training",
    "Prefer not to say",
  ];

  final List<String> height = [
    "Under 5'0",
    "5'0 to 5'3",
    "5'4 to 5'7",
    "5'8 to 5'11",
    "6'0 to 6'3",
    "Over 6'3",
  ];

  final List<String> sexualOrientation = [
    "Straight",
    "Gay",
    "Lesbian",
    "Bisexual",
    "Pansexual",
    "Asexual",
    "Queer",
    "Questioning",
    "Prefer not to say",
  ];

  final List<String> languagesSpoken = [
    "English",
    "Spanish",
    "French",
    "Tagalog",
    "Vietnamese",
    "Other",
    "Chinese (Mandarin/Cantonese)",
  ];

  final RxInt selectedReligionOption = (-1).obs;
  final RxInt selectedEducationOption = (-1).obs;
  final RxInt selectedWorkOption = (-1).obs;
  final RxInt selectedHeightOption = (-1).obs;
  final RxInt selectedSexualOrientationOption = (-1).obs;
  final RxInt selectedLanguagesSpokenOption = (-1).obs;

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
                    onTap: () => Get.toNamed(AppRoutes.interest),
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
                "Basics",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Be as authentic as you can be",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.035),
              buildTitle(title: "Occupation"),
              CustomTextField(
                prefixIcon: Icons.work,
                prefixIconColor: AppColors.primaryColor,
                hintText: "Occupation",
              ),
              SizedBox(height: Get.height * 0.04),
              Expanded(
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle(title: "What is your Religion"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: religion,
                      selectedOption: selectedReligionOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Education"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: education,
                      selectedOption: selectedEducationOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Height"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: height,
                      selectedOption: selectedHeightOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Sexual Orientation"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: sexualOrientation,
                      selectedOption: selectedSexualOrientationOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Languages Spoken"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: languagesSpoken,
                      selectedOption: selectedLanguagesSpokenOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: 4,
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
                ontap: () => Get.toNamed(AppRoutes.interest),
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

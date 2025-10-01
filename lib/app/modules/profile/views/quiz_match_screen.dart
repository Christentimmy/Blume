import 'package:blume/app/modules/profile/widgets/list_tile_widget.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizMatchScreen extends StatelessWidget {
  QuizMatchScreen({super.key});

  final List<String> loveLanguage = [
    "Physical Touch",
    "Quality Time",
    "Receiving Gifts",
    "Acts of Service",
    "Words of Affirmation",
  ];

  final List<String> fanOfNewFood = ["Yes", "No"];
  final List<String> loveAtFirstSight = ["Yes", "No"];
  final List<String> areYouRomantic = ["Yes", "No"];
  final List<String> petLove = ["Yes", "No"];
  final List<String> spontaneousAdventures = ["Yes", "No"];
  final List<String> peopleCulture = ["Yes", "No"];
  final List<String> intellectualConversation = ["Yes", "No"];
  final List<String> travelAdventure = ["Yes", "No"];

  final RxInt selectedLoveAtFirstSightOption = (-1).obs;
  final RxInt selectedPetLoveOption = (-1).obs;
  final RxInt selectedLoveLanguageOption = (-1).obs;
  final RxInt selectedFanOfNewFoodOption = (-1).obs;
  final RxInt selectedAreYouRomanticOption = (-1).obs;
  final RxInt selectedSpontaneousAdventuresOption = (-1).obs;
  final RxInt selectedPeopleCultureOption = (-1).obs;
  final RxInt selectedIntellectualConversationOption = (-1).obs;
  final RxInt selectedTravelAdventureOption = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: ListView(
            children: [
              SizedBox(height: Get.height * 0.02),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "Quiz Match",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "more of what you like",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              buildTitle(title: "Love at first sight"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: loveAtFirstSight,
                selectedOption: selectedLoveAtFirstSightOption,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTitle(title: "Are you a pet lover"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: petLove,
                selectedOption: selectedPetLoveOption,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTitle(title: "What is your love language?"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: loveLanguage,
                selectedOption: selectedLoveLanguageOption,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTitle(title: "Are you a fan of trying new food"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: fanOfNewFood,
                selectedOption: selectedFanOfNewFoodOption,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTitle(title: "Are you romantic?"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: areYouRomantic,
                selectedOption: selectedAreYouRomanticOption,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTitle(title: "Do you enjoy spontaneous adventures"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: spontaneousAdventures,
                selectedOption: selectedSpontaneousAdventuresOption,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTitle(title: "Are you interested in learning about other people’s culture"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: peopleCulture,
                selectedOption: selectedPeopleCultureOption,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTitle(title: "Do you enjoy intellectual conversations"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: intellectualConversation,
                selectedOption: selectedIntellectualConversationOption,
              ),
              SizedBox(height: Get.height * 0.03),
              buildTitle(title: "Do you enjoy travel adventures"),
              SizedBox(height: Get.height * 0.01),
              buildOptions(
                options: travelAdventure,
                selectedOption: selectedTravelAdventureOption,
              ),
              SizedBox(height: Get.height * 0.03),
              CustomButton(
                ontap: () => Get.toNamed(AppRoutes.religionWork),
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

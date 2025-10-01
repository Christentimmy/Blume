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
    "History",
    "Science & tech",
    "Languages",
    "Chess",
    "Puzzles",
  ];

  final List<String> artsAndCrafts = [
    "Drawing",
    "Painting",
    "Photography",
    "Fashion",
    "Music",
    "Crafts/DIY"
        "Dancing",
  ];

  final List<String> sportsAndLeisure = [
    "Gym workouts",
    "Running",
    "Yoga",
    "Cycling",
    "Hiking",
    "Dancing",
    "Golf",
    "Basketball",
    "Soccer",
    "Tennis",
    "Volleyball",
    "Badminton",
    "Table Tennis",
    "Chess",
    "Puzzles",
    "Other",
    "Prefer not to say",
  ];

  final List<String> travelAndAdventure = [
    "Road trip",
    "Backpacking",
    "Camping",
    "Beach vacations",
    "Cruise trips",
    "Hiking",
    "City exploration",
  ];

  final List<String> entertainment = [
    "Movies",
    "TV series",
    "Theater",
    "Stand-up comedy",
    "Anime",
    "Gaming",
    "Podcasts",
  ];

  final List<String> music = [
    "Pop",
    "Hip-hop/Rap",
    "Rock",
    "Jazz",
    "Classical",
    "EDM/Dance",
    "Live concerts",
  ];

  final List<String> foodAndDrink = [
    "Cooking",
    "Baking",
    "Coffee",
    "Wine",
    "Beer tasting",
    "Street food",
    "Fine dining",
    "Vegan/Vegetarian lifestyle"
  ];

  final RxInt selectedLifestyleOption = (-1).obs;
  final RxInt selectedHobbiesOption = (-1).obs;
  final RxInt selectedArtsAndCraftsOption = (-1).obs;
  final RxInt selectedSportsAndLeisureOption = (-1).obs;
  final RxInt selectedTravelAndAdventureOption = (-1).obs;
  final RxInt selectedEntertainmentOption = (-1).obs;
  final RxInt selectedMusicOption = (-1).obs;
  final RxInt selectedFoodAndDrinkOption = (-1).obs;

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
                    buildTitle(title: "Arts & Crafts"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: artsAndCrafts,
                      selectedOption: selectedArtsAndCraftsOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Sports & Fitness"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: sportsAndLeisure,
                      selectedOption: selectedSportsAndLeisureOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Travel & Adventure"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: travelAndAdventure,
                      selectedOption: selectedTravelAndAdventureOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Entertainment"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: entertainment,
                      selectedOption: selectedEntertainmentOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Music"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: music,
                      selectedOption: selectedMusicOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Food & Drink"),
                    SizedBox(height: Get.height * 0.01),
                    buildOptions(
                      options: foodAndDrink,
                      selectedOption: selectedFoodAndDrinkOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
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

import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/modules/profile/widgets/list_tile_widget.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InterestScreen extends StatefulWidget {
  final VoidCallback? whatNext;
  final Basics? basics;
  const InterestScreen({super.key, this.whatNext, this.basics});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final List<String> lifestyle = [
    "Volunteering",
    "Sustainability",
    "Spirituality",
    "Minimalism",
    "Mindfulness",
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
    "Crafts/DIY",
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
    "Vegan/Vegetarian lifestyle",
  ];

  final RxList<String> selectedLifestyleOption = <String>[].obs;

  // final RxInt selectedLifestyleOption = (-1).obs;
  final RxList<String> selectedHobbiesOption = <String>[].obs;

  final RxList<String> selectedArtsAndCraftsOption = <String>[].obs;

  final RxList<String> selectedSportsAndLeisureOption = <String>[].obs;

  final RxList<String> selectedTravelAndAdventureOption = <String>[].obs;

  final RxList<String> selectedEntertainmentOption = <String>[].obs;

  final RxList<String> selectedMusicOption = <String>[].obs;

  final RxList<String> selectedFoodAndDrinkOption = <String>[].obs;

  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(widget.basics?.lifestyleAndValues);
      if (widget.basics == null) return;
      selectedLifestyleOption.value = widget.basics?.lifestyleAndValues ?? [];
      selectedHobbiesOption.value = widget.basics?.hobbies ?? [];
      selectedArtsAndCraftsOption.value =
          widget.basics?.artsAndCreativity ?? [];
      selectedSportsAndLeisureOption.value =
          widget.basics?.sportsAndFitness ?? [];
      selectedTravelAndAdventureOption.value =
          widget.basics?.travelAndAdventure ?? [];
      selectedEntertainmentOption.value = widget.basics?.entertainment ?? [];
      selectedMusicOption.value = widget.basics?.music ?? [];
      selectedFoodAndDrinkOption.value = widget.basics?.foodAndDrink ?? [];
    });
  }

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
                    buildListOptions(
                      options: lifestyle,
                      selectedOptions: selectedLifestyleOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Learning & Hobbies"),
                    SizedBox(height: Get.height * 0.01),
                    buildListOptions(
                      options: hobbies,
                      selectedOptions: selectedHobbiesOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Arts & Crafts"),
                    SizedBox(height: Get.height * 0.01),
                    buildListOptions(
                      options: artsAndCrafts,
                      selectedOptions: selectedArtsAndCraftsOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Sports & Fitness"),
                    SizedBox(height: Get.height * 0.01),
                    buildListOptions(
                      options: sportsAndLeisure,
                      selectedOptions: selectedSportsAndLeisureOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Travel & Adventure"),
                    SizedBox(height: Get.height * 0.01),
                    buildListOptions(
                      options: travelAndAdventure,
                      selectedOptions: selectedTravelAndAdventureOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Entertainment"),
                    SizedBox(height: Get.height * 0.01),
                    buildListOptions(
                      options: entertainment,
                      selectedOptions: selectedEntertainmentOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Music"),
                    SizedBox(height: Get.height * 0.01),
                    buildListOptions(
                      options: music,
                      selectedOptions: selectedMusicOption,
                    ),
                    SizedBox(height: Get.height * 0.03),
                    buildTitle(title: "Food & Drink"),
                    SizedBox(height: Get.height * 0.01),
                    buildListOptions(
                      options: foodAndDrink,
                      selectedOptions: selectedFoodAndDrinkOption,
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
                ontap: () async {
                  List<String>? sLifeStyle;
                  List<String>? sHobbies;
                  List<String>? sArtsAndCrafts;
                  List<String>? sSportsAndLeisure;
                  List<String>? sTravelAndAdventure;
                  List<String>? sEntertainment;
                  List<String>? sMusic;
                  List<String>? sFoodAndDrink;

                  if (selectedLifestyleOption.length > 1) {
                    sLifeStyle = selectedLifestyleOption;
                  }
                  if (selectedHobbiesOption.length > 1) {
                    sHobbies = selectedHobbiesOption;
                  }
                  if (selectedArtsAndCraftsOption.length > 1) {
                    sArtsAndCrafts = selectedArtsAndCraftsOption;
                  }
                  if (selectedSportsAndLeisureOption.length > 1) {
                    sSportsAndLeisure = selectedSportsAndLeisureOption;
                  }
                  if (selectedTravelAndAdventureOption.length > 1) {
                    sTravelAndAdventure = selectedTravelAndAdventureOption;
                  }
                  if (selectedEntertainmentOption.length > 1) {
                    sEntertainment = selectedEntertainmentOption;
                  }
                  if (selectedMusicOption.length > 1) {
                    sMusic = selectedMusicOption;
                  }
                  if (selectedFoodAndDrinkOption.length > 1) {
                    sFoodAndDrink = selectedFoodAndDrinkOption;
                  }

                  await userController.updateBasic2(
                    lifestyleAndValues: sLifeStyle,
                    hobbies: sHobbies,
                    artsAndCreativity: sArtsAndCrafts,
                    sportsAndFitness: sSportsAndLeisure,
                    travelAndAdventure: sTravelAndAdventure,
                    entertainment: sEntertainment,
                    music: sMusic,
                    foodAndDrink: sFoodAndDrink,
                    whatNext: widget.whatNext,
                  );
                },
                isLoading: userController.isloading,
                child: Text(
                  widget.basics == null ? "Next" : "Save",
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

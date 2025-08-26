import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final List filter = [
    "Age",
    "NearBy",
    "Verified profile",
    "Aligned interests",
    "Relationship",
    "Education",
    "Lifestyle",
    "Religion",
    "Work",
    "Interest",
  ];

  final List interests = [
    "Art & Design 🎨",
    "Video games 🎮",
    "Music 🎶",
    "Culture 🪭",
    "Movies 🎥",
    "Traveling ✈️",
    "Camping 🏕️",
    "People nearby 📍",
    "Most compatible 🔗",
  ];

  final List goalDrivenDating = [
    {"title": "Serious Dater", "image": "assets/icons/love.png"},
    {"title": "New friends", "image": "assets/icons/newF.png"},
    {"title": "Short-term fun", "image": "assets/icons/flash.png"},
    {"title": "Free tonight", "image": "assets/icons/moon.png"},
  ];

  late AnimationController _animationController;
  late Animation<double> _searchWidthAnimation;
  late Animation<double> _titleOpacityAnimation;
  late Animation<double> _arrowOpacityAnimation;
  bool _isSearchActive = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _searchWidthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _titleOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _arrowOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
    });

    if (_isSearchActive) {
      _animationController.forward();
      // Delay focus to allow animation to start
      Future.delayed(Duration(milliseconds: 150), () {
        _searchFocusNode.requestFocus();
      });
    } else {
      _animationController.reverse();
      _searchFocusNode.unfocus();
      _searchController.clear();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar(),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      "Interest",
                      style: GoogleFonts.figtree(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    Text(
                      "People with similar interest around you",
                      style: GoogleFonts.figtree(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Wrap(
                      runSpacing: 2,
                      spacing: 5,
                      children: List.generate(
                        interests.length,
                        (index) => Chip(
                          side: BorderSide(color: Colors.transparent),
                          backgroundColor: Get.isDarkMode
                              ? AppColors.darkButtonColor
                              : AppColors.lightButtonColor,
                          label: Text(
                            interests[index],
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Text(
                      "Goal-driven dating",
                      style: GoogleFonts.figtree(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    Text(
                      "People with similar relationship goals",
                      style: GoogleFonts.figtree(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: goalDrivenDating.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final item = goalDrivenDating[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 45,
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  color: Get.isDarkMode
                                      ? AppColors.darkButtonColor
                                      : AppColors.lightButtonColor,
                                ),
                                child: Text(
                                  item["title"],
                                  style: GoogleFonts.figtree(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Get.theme.primaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Image.asset(item["image"], height: 50),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: Get.height * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return SizedBox(
      height: Get.height * 0.14,
      width: Get.width,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Row(
                children: [
                  // Arrow back icon
                  AnimatedBuilder(
                    animation: _arrowOpacityAnimation,
                    builder: (context, child) {
                      return _arrowOpacityAnimation.value > 0
                          ? Opacity(
                              opacity: _arrowOpacityAnimation.value,
                              child: IconButton(
                                onPressed: _toggleSearch,
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Get.theme.primaryColor,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 40,
                                  minHeight: 40,
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    },
                  ),

                  // Title with fade animation
                  AnimatedBuilder(
                    animation: _titleOpacityAnimation,
                    builder: (context, child) {
                      return _titleOpacityAnimation.value > 0
                          ? Opacity(
                              opacity: _titleOpacityAnimation.value,
                              child: Text(
                                "Explore",
                                style: GoogleFonts.figtree(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    },
                  ),

                  // Animated search field - THIS IS THE FIX
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _searchWidthAnimation,
                      builder: (context, child) {
                        return _searchWidthAnimation.value > 0
                            ? Opacity(
                                opacity: _searchWidthAnimation.value,
                                child: CustomTextField(
                                  hintText: "Search",
                                  suffixIcon: Icons.search,
                                ),
                              )
                            : SizedBox.shrink();
                      },
                    ),
                  ),

                  // Search icon button
                  AnimatedBuilder(
                    animation: _titleOpacityAnimation,
                    builder: (context, child) {
                      return _titleOpacityAnimation.value > 0
                          ? Opacity(
                              opacity: _titleOpacityAnimation.value,
                              child: IconButton(
                                onPressed: _toggleSearch,
                                icon: Icon(Icons.search),
                              ),
                            )
                          : SizedBox(width: 10);
                    },
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: Get.height * 0.05,
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Icon(Icons.filter_list_rounded),
                SizedBox(width: 10),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filter.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 2,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? AppColors.darkButtonColor
                              : AppColors.lightButtonColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          filter[index],
                          style: GoogleFonts.figtree(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

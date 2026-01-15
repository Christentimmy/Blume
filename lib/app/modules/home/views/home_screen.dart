import 'dart:ui';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/utils/age_calculator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:appinio_swiper/appinio_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // QuizMatchDialog.show(context);
      if (userController.potentialMatchesList.isNotEmpty) return;
      userController.getPotentialMatches();
    });
  }

  final userController = Get.put(UserController());
  final appinioSwiperController = AppinioSwiperController();

  // final List<String> images = [
  //   "assets/images/plm.png",
  //   "assets/images/frm.png",
  //   "assets/images/plm.png",
  //   "assets/images/frm.png",
  // ];

  final swiperController = AppinioSwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Blume",
                    style: GoogleFonts.figtree(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.notification),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.notifications),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: Stack(
                  children: [
                    // buildOldSwiper(),
                    Obx(() {
                      if (userController.isloading.value) {
                        return const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      }
                      if (userController.potentialMatchesList.isEmpty) {
                        return Center(
                          child: Text(
                            "No matches found",
                            style: GoogleFonts.figtree(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      }
                      final potentialList = userController.potentialMatchesList;
                      return AppinioSwiper(
                        controller: appinioSwiperController,
                        cardCount: potentialList.length,
                        loop: false,
                        onEnd: () async {
                          await userController.getPotentialMatches(
                            loadMore: true,
                          );
                        },
                        backgroundCardOffset: Offset(0, -45),
                        onSwipeEnd: userController.onSwipeEnd,
                        cardBuilder: (context, index) {
                          final activeIndex = 0.obs;
                          return buildCard(
                            user: potentialList[index],
                            activeIndex: activeIndex,
                          );
                        },
                      );
                    }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildActionButton(
                            icon: FontAwesomeIcons.arrowsRotate,
                            onTap: () async {
                              if (userController.user.value?.plan == "free")
                                return;
                              swiperController.unswipe();
                            },
                          ),
                          buildActionButton(
                            size: 75,
                            icon: FontAwesomeIcons.xmark,
                            onTap: () async {
                              swiperController.swipeLeft();
                            },
                          ),
                          buildActionButton(
                            icon: FontAwesomeIcons.solidHeart,
                            onTap: () async {
                              swiperController.swipeRight();
                            },
                            size: 75,
                          ),

                          buildActionButton(
                            icon: FontAwesomeIcons.paperPlane,
                            onTap: () async {
                              swiperController.swipeRight();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // SizedBox(height: Get.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCard({required RxInt activeIndex, required UserModel user}) {
    List interests = userController.getInterests(user: user);
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.05),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: PageView.builder(
              onPageChanged: (value) {
                activeIndex.value = value;
              },
              itemCount: user.photos?.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: user.photos![index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Shimmer.fromColors(
                      baseColor: Color(0xFF1A1625),
                      highlightColor: AppColors.primaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF1A1625),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                );
              },
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: List.generate(user.photos?.length ?? 0, (i) {
                    return Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 4,
                        decoration: BoxDecoration(
                          color: i == activeIndex.value
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: Get.height * 0.22,
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      "${user.fullName?.split(" ").first} ${calculateAge(user.dateOfBirth)}",
                      style: GoogleFonts.figtree(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    user.isVerified == true
                        ? Icon(Icons.verified, size: 20, color: Colors.blue)
                        : SizedBox.shrink(),
                    const Spacer(),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Icon(
                        FontAwesomeIcons.circleExclamation,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.fence_sharp, color: Colors.white),
                    Text(
                      "Interest",
                      style: GoogleFonts.figtree(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: Get.height * 0.01),
                Wrap(
                  spacing: 2,
                  children: interests
                      .map(
                        (e) => Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.3),
                          label: Text(
                            e,
                            style: GoogleFonts.figtree(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                // Row(
                //   children: [
                //     Chip(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(22),
                //       ),
                //       backgroundColor: Colors.white.withOpacity(0.3),
                //       label: Text(
                //         "Interest",
                //         style: GoogleFonts.figtree(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w600,
                //           // color: Colors.white,
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 5),
                //     Chip(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(22),
                //       ),
                //       backgroundColor: Colors.white.withOpacity(0.3),
                //       label: Text(
                //         "Music",
                //         style: GoogleFonts.figtree(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w600,
                //           // color: Colors.white,
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 5),
                //     Chip(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(22),
                //       ),
                //       backgroundColor: Colors.white.withOpacity(0.3),
                //       label: Text(
                //         "Games",
                //         style: GoogleFonts.figtree(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w600,
                //           // color: Colors.white,
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 5),
                //     Chip(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(22),
                //       ),
                //       backgroundColor: Colors.white.withOpacity(0.3),
                //       label: Text(
                //         "Books",
                //         style: GoogleFonts.figtree(
                //           fontSize: 13,
                //           fontWeight: FontWeight.w600,
                //           // color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: Get.height * 0.014),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionButton({
    required IconData icon,
    VoidCallback? onTap,
    double? size,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        width: size ?? 60,
        height: size ?? 60,
        margin: EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          shape: BoxShape.circle,
          color: Get.isDarkMode ? Color(0xFF1E1E1E) : Color(0xFFFFFFFF),
        ),
        child: Icon(icon, color: AppColors.primaryColor),
      ),
    );
  }
}

class QuizMatchDialog {
  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Quiz Match',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final curvedAnimation = CurvedAnimation(
          parent: anim1,
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
        );

        return ScaleTransition(
          scale: curvedAnimation,
          child: FadeTransition(
            opacity: anim1,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Get.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: Get.isDarkMode
                        ? [
                            AppColors.darkBackground,
                            AppColors.darkBackground.withOpacity(0.95),
                          ]
                        : [
                            AppColors.lightBackground,
                            AppColors.secondaryColor.withOpacity(0.5),
                          ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.quiz,
                              size: 56,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Try Quiz Match?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    // Description
                    Text(
                      'Test your knowledge and challenge yourself with our exciting quiz match!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Buttons
                    Row(
                      children: [
                        // Cancel Button
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Get.isDarkMode
                                  ? AppColors.darkButtonColor
                                  : AppColors.lightButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Maybe Later',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Confirm Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Get.offNamed(AppRoutes.quizMatch);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Let\'s Go!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

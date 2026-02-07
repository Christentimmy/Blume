import 'dart:ui';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/utils/age_calculator.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class InterestResultScreen extends StatefulWidget {
  const InterestResultScreen({super.key});

  @override
  State<InterestResultScreen> createState() => _InterestResultScreenState();
}

class _InterestResultScreenState extends State<InterestResultScreen> {
  final userController = Get.put(UserController());
  final swiperController = AppinioSwiperController();

  @override
  void dispose() {
    userController.interestResults.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text(
          "Blume",
          style: GoogleFonts.figtree(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      if (userController.interestResults.isEmpty) {
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
                      final potentialList = userController.interestResults;
                      return AppinioSwiper(
                        controller: swiperController,
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
                              HapticFeedback.lightImpact();
                              if (userController.user.value?.plan == "free") {
                                CustomSnackbar.showErrorToast(
                                  "Kindly subscribe",
                                );
                                return;
                              }
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
          if (user.photos != null && user.photos!.isNotEmpty)
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

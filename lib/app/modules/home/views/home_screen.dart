import 'dart:ui';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              SizedBox(height: Get.height * 0.05),
              Expanded(
                child: AppinioSwiper(
                  cardCount: 20,
                  backgroundCardCount: 2,
                  backgroundCardOffset: Offset(0, -45),
                  onSwipeEnd: (previousIndex, targetIndex, activity) {
                    Get.toNamed(AppRoutes.match);
                  },
                  cardBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/frm.png",
                                fit: BoxFit.cover,
                              ),
                            ),
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
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    height: Get.height * 0.18,
                                    color: Colors.black.withOpacity(0),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Blaire  23",
                                      style: GoogleFonts.figtree(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white.withOpacity(
                                        0.2,
                                      ),
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
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "5 miles away",
                                      style: GoogleFonts.figtree(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height * 0.01),
                                Text(
                                  "“I’ll fall for you if you love dogs 🐶 and good jollof rice 🍛.” Christian girlie!! I think I hate skating too.",
                                  style: GoogleFonts.figtree(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.01),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildActionButton(
                    icon: FontAwesomeIcons.arrowsRotate,
                    onTap: () {},
                  ),
                  buildActionButton(
                    size: 35,
                    icon: FontAwesomeIcons.xmark,
                    onTap: () {},
                  ),
                  buildActionButton(
                    icon: FontAwesomeIcons.solidHeart,
                    onTap: () {},
                    size: 35,
                  ),

                  buildActionButton(
                    icon: FontAwesomeIcons.paperPlane,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          radius: size ?? 30,
          backgroundColor: Get.isDarkMode
              ? AppColors.darkButtonColor
              : AppColors.lightButtonColor,
          child: Icon(icon, color: Get.theme.primaryColor),
        ),
      ),
    );
  }
}

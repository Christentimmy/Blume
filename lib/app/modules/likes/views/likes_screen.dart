import 'dart:ui';

import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/utils/age_calculator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.usersWhoLikesMeList.isNotEmpty) return;
      userController.getUserWhoLikesMe();
    });
  }

  @override
  void dispose() {
    userController.isloading.value = false;
    super.dispose();
  }

  final List filter = [
    "BIo added",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Obx(() {
          if (userController.isloading.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }
          if (userController.usersWhoLikesMeList.isEmpty) {
            return Center(
              child: Text(
                "No users found",
                style: GoogleFonts.figtree(
                  fontSize: 22,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }
          return buildGridViewer();
        }),
      ),
    );
  }

  Padding buildGridViewer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        itemCount: userController.usersWhoLikesMeList.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final user = userController.usersWhoLikesMeList[index];
          return buildLikeCard(user: user);
        },
      ),
    );
  }

  Stack buildLikeCard({required UserModel user}) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: user.avatar ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Color(0xFF1A1625),
                  highlightColor: Color(0xFFD586D3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF1A1625),
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error, color: AppColors.primaryColor),
              ),
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
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: Get.height * 0.07,
                  color: Colors.black.withValues(alpha: 0),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${user.fullName}  ${calculateAge(user.dateOfBirth)}",
                style: GoogleFonts.figtree(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 15),
                  Text(
                    user.location??"",
                    style: GoogleFonts.figtree(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: Icon(
              FontAwesomeIcons.solidHeart,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      title: Text(
        "Likes",
        style: GoogleFonts.figtree(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: Get.theme.primaryColor,
        ),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.notifications))],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.05),
        child: Container(
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
      ),
    );
  }
}

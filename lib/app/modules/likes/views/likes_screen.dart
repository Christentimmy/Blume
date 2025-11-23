import 'dart:ui';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
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
  PageController pageController = PageController();
  final activeIndex = 0.obs;
  RxString title = "Likes".obs;
  final selectedFilter = (-1).obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.matchesList.isEmpty) {
        userController.getMatches();
      }
      if (userController.usersWhoLikesMeList.isEmpty) {
        userController.getUserWhoLikesMe();
      }
    });
  }

  @override
  void dispose() {
    userController.isloading.value = false;
    pageController.dispose();
    super.dispose();
  }

  final List filters = [
    // "BIo added",
    // "NearBy",
    "Verified profile",
    "Aligned interests",
    // "Relationship",
    "Education",
    "Lifestyle",
    "Religion",
    "Work",
    // "Interest",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (value) {
            activeIndex.value = value;
          },
          children: [
            buildLikesGridViewer(),
            buildMatchesGridViewer(),
            // buildMyLikesGridViewer(),
          ],
        ),
      ),
    );
  }

  Widget buildLikesGridViewer() {
    return Obx(() {
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
    });
  }

  Padding buildMyLikesGridViewer() {
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

  Widget buildMatchesGridViewer() {
    return Obx(() {
      if (userController.isloading.value) {
        return Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        );
      }
      if (userController.matchesList.isEmpty) {
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridView.builder(
          itemCount: userController.matchesList.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final user = userController.matchesList[index];
            return buildLikeCard(user: user);
          },
        ),
      );
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      title: GestureDetector(
        onTapDown: (details) async {
          final RenderBox overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;

          final value = await showMenu<String>(
            context: context,
            position: RelativeRect.fromRect(
              details.globalPosition & const Size(40, 40),
              Offset.zero & overlay.size,
            ),
            items: [
              PopupMenuItem(value: "likes", child: Text("Likes")),
              PopupMenuItem(value: "matches", child: Text("Matches")),
            ],
          );
          print(pageController.hasClients);
          if (value == null) return;
          if (!pageController.hasClients) return;
          if (value == "likes") {
            title.value = "Likes";
            pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else if (value == "matches") {
            title.value = "Matches";
            pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Row(
          children: [
            Obx(
              () => Text(
                "${title.value} ",
                style: GoogleFonts.figtree(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.notifications))],
      bottom: buildBottomFilter(),
    );
  }

  PreferredSize buildBottomFilter() {
    return PreferredSize(
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
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  String filter = filters[index];
                  return InkWell(
                    onTap: () async {
                      if (selectedFilter.value == index) {
                        await userController.getUserWhoLikesMe();
                        await userController.getMatches();
                        selectedFilter.value = -1;
                        return;
                      }
                      selectedFilter.value = index;
                      if (activeIndex.value == 0) {
                        await userController.getUserWhoLikesMe(status: filter);
                      } else {
                        await userController.getMatches(status: filter);
                      }
                    },
                    child: Obx(
                      () => Container(
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
                          border: selectedFilter.value == index
                              ? Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1.5,
                                )
                              : null,
                        ),
                        child: Text(
                          filter,
                          style: GoogleFonts.figtree(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildLikeCard({required UserModel user}) {
  return InkWell(
    onTap: () {
      Get.toNamed(
        AppRoutes.profile,
        arguments: {'isSwipeProfile': true, 'userId': user.id},
      );
    },
    child: Stack(
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
                "${user.fullName?.split(" ").first}  ${calculateAge(user.dateOfBirth)}",
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
                    user.location ?? "",
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
    ),
  );
}

import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/chat_list_model.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/utils/age_calculator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  final bool isSwipeProfile;
  final String? userId;
  const ProfileScreen({super.key, required this.isSwipeProfile, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userController = Get.find<UserController>();

  final isloading = true.obs;
  final isBioExpanded = false.obs;
  Rxn<UserModel> userModel = Rxn<UserModel>();

  Future<void> getUserDetails() async {
    isloading.value = true;
    try {
      if (widget.userId == null) {
        userModel.value = userController.user.value;
        return;
      }
      final user = await userController.getUserWithId(userId: widget.userId!);
      if (user == null) return;
      userModel.value = user;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            if (isloading.value) {
              return SizedBox(
                width: Get.width,
                height: Get.height,
                child: const Center(
                  child: CupertinoActivityIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.02),
                _buildHeader(),

                SizedBox(height: Get.height * 0.03),

                // Profile Avatar and Stats
                _buildProfileSection(),

                SizedBox(height: Get.height * 0.04),

                // Bio Section
                _buildBioSection(),

                if (!widget.isSwipeProfile) SizedBox(height: Get.height * 0.04),

                // Profile Boosts
                if (!widget.isSwipeProfile) _buildProfileBoosts(),

                SizedBox(height: Get.height * 0.04),

                // Profile Details
                _buildProfileDetails(),

                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gallery',
                        style: GoogleFonts.figtree(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'See All',
                        style: GoogleFonts.figtree(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Obx(
                            () => Image.network(
                              userModel.value?.photos?[0] ?? "",
                              fit: BoxFit.cover,
                              height: Get.height * 0.35,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Obx(
                            () => Image.network(
                              userModel.value?.photos?[1] ?? "",
                              fit: BoxFit.cover,
                              height: Get.height * 0.35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, size: 28),
          ),
          SizedBox(width: Get.width * 0.03),
          Obx(() {
            return Text(
              userModel.value?.fullName ?? "",
              style: GoogleFonts.figtree(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            );
          }),
          const Spacer(),
          if (widget.isSwipeProfile) ...[
            IconButton(
              onPressed: () {
                final chatHead = ChatListModel(
                  userId: userModel.value?.id,
                  fullName: userModel.value?.fullName,
                  avatar: userModel.value?.avatar,
                  online: false,
                );
                Get.toNamed(
                  AppRoutes.message,
                  arguments: {"chatHead": chatHead},
                );
              },
              icon: Icon(Icons.message_rounded, size: 28),
            ),
          ] else ...[
            Icon(Icons.notifications_outlined, size: 28),
            SizedBox(width: 16),
            Icon(Icons.apps, size: 28),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        children: [
          // Profile Avatar
          Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: CachedNetworkImage(
                imageUrl: userModel.value?.avatar ?? "",
                width: 80,
                height: 80,
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

          // Container(
          //   width: 80,
          //   height: 80,
          //   decoration: BoxDecoration(
          //     color: Color(0xFF8B4513),
          //     shape: BoxShape.circle,
          //   ),
          //   child: Center(
          //     child: Text(
          //       'D',
          //       style: GoogleFonts.figtree(
          //         color: Colors.white,
          //         fontSize: 36,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(width: Get.width * 0.02),

          // Stats
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('3', 'Matches'),
                _buildStatItem('242', 'Likes'),
                _buildStatItem('10', 'Friends'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.figtree(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(label, style: GoogleFonts.figtree(fontSize: 16)),
      ],
    );
  }

  Widget _buildBioSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bio',
            style: GoogleFonts.figtree(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Obx(() {
            return Text(
              userModel.value?.bio ?? "",
              style: GoogleFonts.figtree(fontSize: 16),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProfileBoosts() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile boosts',
            style: GoogleFonts.figtree(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Boost your profile for more visibility',
            style: GoogleFonts.figtree(fontSize: 16),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildBoostCard('\$2', '1 boost'),
              SizedBox(width: 16),
              _buildBoostCard('\$5', '5 boosts'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBoostCard(String price, String description) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.chooseBoostPlan),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? AppColors.darkButtonColor
                : AppColors.lightButtonColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                price,
                style: GoogleFonts.figtree(
                  color: AppColors.primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.figtree(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Obx(
        () => Column(
          children: [
            _buildDetailSection(
              'Age',
              calculateAge(userModel.value?.dateOfBirth ?? ""),
            ),
            SizedBox(height: 15),
            _buildDetailSection('Location', userModel.value?.location ?? ""),
            SizedBox(height: 15),
            _buildInterestsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.figtree(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Icon(Icons.edit, color: Colors.grey[500], size: 20),
          ],
        ),
        SizedBox(height: 4),
        Text(content, style: GoogleFonts.figtree(fontSize: 16)),
      ],
    );
  }

  Widget buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Location',
              style: GoogleFonts.figtree(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.edit, size: 20),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chicago, IL United States',
              style: GoogleFonts.figtree(fontSize: 16),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, color: Colors.red, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '1 km',
                    style: GoogleFonts.figtree(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    List interests = userController.getInterests(
      user: userModel.value!,
      take: 7,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Interests',
              style: GoogleFonts.figtree(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.edit, size: 20),
          ],
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: interests
              .map((interest) => _buildInterestChip(interest, true))
              .toList(),
          // children: [
          //   _buildInterestChip('Travelling', true),
          //   _buildInterestChip('Books', true),
          //   _buildInterestChip('Music', false),
          //   _buildInterestChip('Dancing', false),
          //   _buildInterestChip('Modeling', false),
          // ],
        ),
      ],
    );
  }

  Widget _buildInterestChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? Colors.red : Colors.grey[600]!,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) Icon(Icons.check, color: Colors.red, size: 16),
          if (isSelected) SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.figtree(
              color: isSelected ? Colors.red : null,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

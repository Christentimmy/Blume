import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/modules/profile/widgets/profile_widget.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
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
  // final isUpdating = false.obs;
  Rxn<UserModel> userModel = Rxn<UserModel>();

  // Controllers for editing
  final bioController = TextEditingController();

  bool get isOwnProfile =>
      widget.userId == null || widget.userId == userController.user.value?.id;
  // final locationController = Get.find<LocationController>();

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
  void dispose() {
    bioController.dispose();
    super.dispose();
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
                ProfileHeader(
                  user: userModel,
                  isSwipeProfile: widget.isSwipeProfile,
                  onBack: Get.back,
                ),
                // SizedBox(height: Get.height * 0.03),
                // ProfileAvatarStats(user: userModel),
                SizedBox(height: Get.height * 0.04),
                ProfileBioSection(
                  user: userModel,
                  isOwnProfile: isOwnProfile,
                  onEditBio: () => showEditBioSheet(userModel: userModel),
                ),
                if (!widget.isSwipeProfile) SizedBox(height: Get.height * 0.04),
                if (!widget.isSwipeProfile) const ProfileBoostsSection(),
                SizedBox(height: Get.height * 0.04),
                ProfileDetailsSection(
                  user: userModel,
                  isOwnProfile: isOwnProfile,
                ),
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
                      InkWell(
                        onTap: () {
                          if (isOwnProfile) {
                            Get.toNamed(AppRoutes.gallery);
                            return;
                          }
                          displayAllPicturesInDialog(userModel: userModel);
                        },
                        child: Text(
                          'See All',
                          style: GoogleFonts.figtree(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
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
                            () => CachedNetworkImage(
                              imageUrl: userModel.value?.photos?[0] ?? "",
                              fit: BoxFit.cover,
                              height: Get.height * 0.35,
                              placeholder: (context, url) => shimmerEffect(),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                    child: Icon(
                                      Icons.error,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                            ),
                            // Image.network(
                            //   userModel.value?.photos?[0] ?? "",
                            //   fit: BoxFit.cover,
                            //   height: Get.height * 0.35,
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Obx(
                            () => CachedNetworkImage(
                              imageUrl: userModel.value?.photos?[1] ?? "",
                              fit: BoxFit.cover,
                              height: Get.height * 0.35,
                              placeholder: (context, url) => shimmerEffect(),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                    child: Icon(
                                      Icons.error,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
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

  Shimmer shimmerEffect() {
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
  }
}

import 'package:blume/app/controller/location_controller.dart';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/chat_list_model.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/utils/age_calculator.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProfileHeader extends StatelessWidget {
  final Rxn<UserModel> user;
  final bool isSwipeProfile;
  final VoidCallback onBack;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.isSwipeProfile,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(onTap: onBack, child: const Icon(Icons.arrow_back, size: 28)),
          SizedBox(width: Get.width * 0.03),
          Obx(() {
            return Text(
              user.value?.fullName ?? "",
              style: GoogleFonts.figtree(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            );
          }),
          const Spacer(),
          if (isSwipeProfile) ...[
            IconButton(
              onPressed: () {
                final chatHead = ChatListModel(
                  userId: user.value?.id,
                  fullName: user.value?.fullName,
                  avatar: user.value?.avatar,
                  online: false,
                );
                Get.toNamed(
                  AppRoutes.message,
                  arguments: {"chatHead": chatHead},
                );
              },
              icon: const Icon(Icons.message_rounded, size: 28),
            ),
          ] else ...[
            const Icon(Icons.notifications_outlined, size: 28),
            const SizedBox(width: 16),
            const Icon(Icons.apps, size: 28),
          ],
        ],
      ),
    );
  }
}

class ProfileAvatarStats extends StatelessWidget {
  final Rxn<UserModel> user;

  const ProfileAvatarStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        children: [
          Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: CachedNetworkImage(
                imageUrl: user.value?.avatar ?? "",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: const Color(0xFF1A1625),
                    highlightColor: const Color(0xFFD586D3),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF1A1625),
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
          SizedBox(width: Get.width * 0.02),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ProfileStatItem(number: '3', label: 'Matches'),
                _ProfileStatItem(number: '242', label: 'Likes'),
                _ProfileStatItem(number: '10', label: 'Friends'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStatItem extends StatelessWidget {
  final String number;
  final String label;

  const _ProfileStatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
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
}

class ProfileBioSection extends StatelessWidget {
  final Rxn<UserModel> user;
  final bool isOwnProfile;
  final VoidCallback onEditBio;

  const ProfileBioSection({
    super.key,
    required this.user,
    required this.isOwnProfile,
    required this.onEditBio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bio',
                style: GoogleFonts.figtree(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isOwnProfile)
                IconButton(
                  onPressed: onEditBio,
                  icon: const Icon(Icons.edit, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Obx(() {
            return Text(
              user.value?.bio ?? 'Add a bio to tell others about yourself',
              style: GoogleFonts.figtree(
                fontSize: 16,
                color: user.value?.bio == null ? Colors.grey : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ProfileBoostsSection extends StatelessWidget {
  const ProfileBoostsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 4),
          Text(
            'Boost your profile for more visibility',
            style: GoogleFonts.figtree(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              _BoostCard(price: '\$2', description: '1 boost'),
              SizedBox(width: 16),
              _BoostCard(price: '\$5', description: '5 boosts'),
            ],
          ),
        ],
      ),
    );
  }
}

class _BoostCard extends StatelessWidget {
  final String price;
  final String description;

  const _BoostCard({required this.price, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.chooseBoostPlan),
        child: Container(
          padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 4),
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
}

class ProfileDetailsSection extends StatelessWidget {
  final Rxn<UserModel> user;
  final bool isOwnProfile;
  final VoidCallback onEditLocation;
  final VoidCallback onEditInterests;

  const ProfileDetailsSection({
    super.key,
    required this.user,
    required this.isOwnProfile,
    required this.onEditLocation,
    required this.onEditInterests,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Obx(() {
        final currentUser = user.value;
        return Column(
          children: [
            _DetailSection(
              title: 'Age',
              content: calculateAge(currentUser?.dateOfBirth ?? ''),
              canEdit: false,
              isOwnProfile: isOwnProfile,
            ),
            const SizedBox(height: 15),
            _DetailSection(
              title: 'Location',
              content: currentUser?.location ?? 'Add your location',
              canEdit: true,
              isOwnProfile: isOwnProfile,
              onEdit: onEditLocation,
            ),
            const SizedBox(height: 15),
            _InterestsSection(
              user: currentUser,
              isOwnProfile: isOwnProfile,
              onEditInterests: onEditInterests,
            ),
          ],
        );
      }),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final String content;
  final bool canEdit;
  final bool isOwnProfile;
  final VoidCallback? onEdit;

  const _DetailSection({
    required this.title,
    required this.content,
    this.canEdit = false,
    required this.isOwnProfile,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
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
            if (canEdit && isOwnProfile)
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: GoogleFonts.figtree(
            fontSize: 16,
            color: content.startsWith('Add') ? Colors.grey : null,
          ),
        ),
      ],
    );
  }
}

class _InterestsSection extends StatelessWidget {
  final UserModel? user;
  final bool isOwnProfile;
  final VoidCallback onEditInterests;

  const _InterestsSection({
    required this.user,
    required this.isOwnProfile,
    required this.onEditInterests,
  });

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const SizedBox.shrink();
    }

    final interests = Get.find<UserController>().getInterests(
      user: user!,
      take: 15,
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
            if (isOwnProfile)
              IconButton(
                onPressed: onEditInterests,
                icon: const Icon(Icons.edit, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: interests.isNotEmpty
              ? interests
                    .map(
                      (interest) => ProfileInterestChip(
                        label: interest,
                        isSelected: true,
                      ),
                    )
                    .toList()
              : [
                  Text(
                    'Add interests to help others know you better',
                    style: GoogleFonts.figtree(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
        ),
      ],
    );
  }
}

class ProfileInterestChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const ProfileInterestChip({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
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
          if (isSelected) const Icon(Icons.check, color: Colors.red, size: 16),
          if (isSelected) const SizedBox(width: 6),
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

void showEditBioSheet({required Rxn<UserModel> userModel}) {
  final bioController = TextEditingController();
  final userController = Get.find<UserController>();
  bioController.text = userModel.value?.bio ?? '';

  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Color(0xFF1A1625) : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Bio',
                style: GoogleFonts.figtree(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            controller: bioController,
            style: GoogleFonts.poppins(fontSize: 12),
            maxLines: 5,
            maxLength: 500,
            decoration: InputDecoration(
              hintText: 'Tell us about yourself...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
          SizedBox(height: 16),

          CustomButton(
            ontap: () async {
              if (bioController.text.isEmpty) return;
              await userController.updateBio(bio: bioController.text);
            },
            isLoading: false.obs,
            child: Text(
              'Save',
              style: GoogleFonts.figtree(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

void showEditLocationSheet({required Rxn<UserModel> userModel}) {
  final locationController = Get.find<LocationController>();
  final userController = Get.find<UserController>();
  Get.bottomSheet(
    isScrollControlled: true,
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Color(0xFF1A1625) : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Location',
                style: GoogleFonts.figtree(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close)),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            style: GoogleFonts.poppins(fontSize: 12),
            decoration: InputDecoration(
              hintText: userModel.value?.location ?? "",
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
          SizedBox(height: 16),
          CustomButton(
            ontap: () async {
              await locationController.getCurrentCity(
                nextScreen: () async {
                  await userController.getUserDetails();
                  Get.back();
                },
              );
            },
            isLoading: locationController.isloading,
            child: Text(
              'Save',
              style: GoogleFonts.figtree(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

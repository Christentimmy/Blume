import 'package:blume/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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

              SizedBox(height: Get.height * 0.04),

              // Profile Boosts
              _buildProfileBoosts(),

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
                        child: Image.asset(
                          'assets/images/plm.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/frm.png',
                          fit: BoxFit.cover,
                        ),
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

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back, size: 28),
          SizedBox(width: Get.width * 0.03),
          Text(
            'Don cullion',
            style: GoogleFonts.figtree(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.verified, color: Colors.purple, size: 20),
          const Spacer(),
          Icon(Icons.notifications_outlined, size: 28),
          SizedBox(width: 16),
          Icon(Icons.apps, size: 28),
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
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFF8B4513),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'D',
                style: GoogleFonts.figtree(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

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
          Text('Bio goes here', style: GoogleFonts.figtree(fontSize: 16)),
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
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        children: [
          _buildDetailSection('Age', '', true),
          SizedBox(height: 24),
          _buildDetailSection(
            'About',
            'My name is Jessica and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading..',
            false,
          ),
          SizedBox(height: 24),
          _buildLocationSection(),
          SizedBox(height: 24),
          _buildInterestsSection(),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, String content, bool isEmpty) {
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
            Icon(Icons.edit, color: Colors.grey[500], size: 20),
          ],
        ),
        if (!isEmpty) ...[
          SizedBox(height: 8),
          Text(content, style: GoogleFonts.figtree(fontSize: 16, height: 1.4)),
          SizedBox(height: 8),
          Text(
            'Read more',
            style: GoogleFonts.figtree(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLocationSection() {
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
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildInterestChip('Travelling', true),
            _buildInterestChip('Books', true),
            _buildInterestChip('Music', false),
            _buildInterestChip('Dancing', false),
            _buildInterestChip('Modeling', false),
          ],
        ),
      ],
    );
  }

  Widget _buildInterestChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

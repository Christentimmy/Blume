import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'More',
          style: GoogleFonts.figtree(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.02),
              buildSettingTile(
                title: 'My Profile',
                icon: Icons.person_2_outlined,
                ontap: () => Get.toNamed(AppRoutes.profile),
              ),
              buildSettingTile(
                title: 'App Settings',
                icon: Icons.settings_outlined,
              ),
              buildSettingTile(title: 'Discovery settings', icon: Icons.map),
              buildSettingTile(
                title: 'Subscriptions',
                icon: Icons.wallet_outlined,
                ontap: () => Get.toNamed(AppRoutes.subscription),
              ),
              buildSettingTile(
                title: 'Contact',
                icon: Icons.help_outline_outlined,
              ),
              buildSettingTile(
                title: 'Selfie verification',
                icon: Icons.person_outline_outlined,
                ontap: () => Get.toNamed(AppRoutes.disclaimer),
              ),
              buildSettingTile(title: 'Help & Safety', icon: Icons.help),
              SizedBox(height: Get.height * 0.04),
              CustomButton(
                bgColor: Get.isDarkMode
                    ? AppColors.darkButtonColor
                    : AppColors.lightButtonColor,
                ontap: () {},
                isLoading: false.obs,
                child: Text(
                  'Logout',
                  style: GoogleFonts.figtree(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildSettingTile({
    required String title,
    required IconData icon,
    VoidCallback? ontap,
  }) {
    return ListTile(
      onTap: ontap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(
        title,
        style: GoogleFonts.figtree(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 18),
    );
  }
}

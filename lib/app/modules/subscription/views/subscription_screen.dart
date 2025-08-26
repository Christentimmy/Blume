import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text(
          "Subscription",
          style: GoogleFonts.figtree(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Premium Matches, Premium Love',
                style: GoogleFonts.figtree(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'pick the best plan for you!',
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: Get.height * 0.1),
              buildSubCard(title: 'Basic', price: 10),
              SizedBox(height: Get.height * 0.03),
              buildSubCard(title: 'Premium', price: 30),
              SizedBox(height: Get.height * 0.03),
              buildSubCard(title: 'Premium Plus', price: 35),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSubCard({
    required String title,
    required int price,
  }) {
    return Container(
      width: Get.width,
      height: Get.height * 0.45,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? AppColors.darkButtonColor
            : AppColors.lightButtonColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.figtree(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "\$$price",
              style: GoogleFonts.figtree(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'monthly',
              style: GoogleFonts.figtree(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.03),
          CustomButton(
            ontap: () {},
            isLoading: false.obs,
            child: Text(
              'Get Started',
              style: GoogleFonts.figtree(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 16),
              SizedBox(width: 5),
              Text(
                'You get 7 days free trial',
                style: GoogleFonts.figtree(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 16),
              SizedBox(width: 5),
              Text(
                'You get 7 days free trial',
                style: GoogleFonts.figtree(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 16),
              SizedBox(width: 5),
              Text(
                'You get 7 days free trial',
                style: GoogleFonts.figtree(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 16),
              SizedBox(width: 5),
              Text(
                'You get 7 days free trial',
                style: GoogleFonts.figtree(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

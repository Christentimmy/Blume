import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: GoogleFonts.figtree(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify your account',
                style: GoogleFonts.figtree(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Lets make online dating safe and better by showing you are who you say you are!",
                style: GoogleFonts.figtree(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(),
              Center(
                child: Image.asset(
                  'assets/images/verr.png',
                  height: 200,
                ),
              ),
              Spacer(),
              Center(
                child: Text(
                  "Over 30,000 verified members near you ©",
                  style: GoogleFonts.figtree(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.005),
              CustomButton(
                ontap: () => Get.toNamed(AppRoutes.verification),
                isLoading: false.obs,
                child: Text(
                  'Allow',
                  style: GoogleFonts.figtree(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

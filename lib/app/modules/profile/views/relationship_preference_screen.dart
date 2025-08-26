import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RelationshipPreferenceScreen extends StatelessWidget {
  RelationshipPreferenceScreen({super.key});

  final List relations = [
    "Long term Partner",
    "Short term Partner",
    "Both",
    "New friends",
    "Short term Fun",
    "Not sure yet",
  ];

  final RxInt selectedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "What are you looking for?",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "you birthday is shown on your profile but not your date of birth",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Wrap(
                runSpacing: 10,
                children: relations.map((e) {
                  return InkWell(
                    onTap: () => selectedIndex.value = relations.indexOf(e),
                    child: Obx(
                      () => Container(
                        width: Get.height * 0.137,
                        height: Get.width * 0.215,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: selectedIndex.value == relations.indexOf(e)
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          e,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.figtree(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: selectedIndex.value == relations.indexOf(e)
                                ? AppColors.primaryColor
                                : Get.theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 7,
                  effect: const WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              CustomButton(
                ontap: () => Get.toNamed(AppRoutes.relationshipPreference),
                isLoading: false.obs,
                child: Text(
                  "Next",
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
      ),
    );
  }
}

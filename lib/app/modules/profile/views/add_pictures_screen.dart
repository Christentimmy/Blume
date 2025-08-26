import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddPicturesScreen extends StatelessWidget {
  const AddPicturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios_new),
                  ),
                  // const Spacer(),
                  // InkWell(
                  //   onTap: () => Get.toNamed(AppRoutes.lifestyle),
                  //   child: Text(
                  //     "Skip",
                  //     style: GoogleFonts.figtree(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //       color: AppColors.primaryColor,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "Add some pictures",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Add 2 to 4 pictures to make your profile stand out",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          // image: DecorationImage(
                          //   image: AssetImage(
                          //     "assets/images/profile.png",
                          //   ),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: 6,
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
                ontap: () => Get.toNamed(AppRoutes.lifestyle),
                isLoading: false.obs,
                child: Text(
                  "Next",
                  style: GoogleFonts.figtree(
                    fontSize: 16,
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

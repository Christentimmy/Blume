import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseBoostPlanScreen extends StatelessWidget {
  ChooseBoostPlanScreen({super.key});

  final boostList = [
    {'title': '1 boost', 'price': '2'},
    {'title': '5 boosts', 'price': '5'},
    {'title': '10 boosts', 'price': '8'},
  ];

  final RxInt selectedIndex = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose your boost plan',
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
                'Profile boosts',
                style: GoogleFonts.figtree(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Boost your profile for more visibility. Become a top profile in your area and get more Likes.",
                style: GoogleFonts.figtree(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Expanded(
                child: ListView.builder(
                  itemCount: boostList.length,
                  itemBuilder: (context, index) {
                    final boost = boostList[index];
                    return Obx(() {
                      return InkWell(
                        onTap: () => selectedIndex.value = index,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: selectedIndex.value == index
                                ? AppColors.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Text(
                                boost['title']!,
                                style: GoogleFonts.figtree(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: selectedIndex.value == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "\$${boost['price']!}",
                                style: GoogleFonts.figtree(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: selectedIndex.value == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
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
                ontap: () {},
                isLoading: false.obs,
                child: Text(
                  'Get boost',
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

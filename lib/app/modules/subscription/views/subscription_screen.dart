import 'package:blume/app/controller/subscription_controller.dart';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// class SubscriptionScreen extends StatelessWidget {
//   const SubscriptionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Get.theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Get.theme.scaffoldBackgroundColor,
//         title: Text(
//           "Subscription",
//           style: GoogleFonts.figtree(fontSize: 22, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Premium Matches, Premium Love',
//                 style: GoogleFonts.figtree(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 'pick the best plan for you!',
//                 style: GoogleFonts.figtree(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: Get.height * 0.1),
//               buildSubCard(title: 'Basic', price: 10),
//               SizedBox(height: Get.height * 0.03),
//               buildSubCard(title: 'Premium', price: 30),
//               SizedBox(height: Get.height * 0.03),
//               buildSubCard(title: 'Premium Plus', price: 35),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSubCard({
//     required String title,
//     required int price,
//   }) {
//     return Container(
//       width: Get.width,
//       height: Get.height * 0.5,
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//       margin: EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Get.isDarkMode
//             ? AppColors.darkButtonColor
//             : AppColors.lightButtonColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: GoogleFonts.figtree(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 10),
//           Center(
//             child: Text(
//               "\$$price",
//               style: GoogleFonts.figtree(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Center(
//             child: Text(
//               'monthly',
//               style: GoogleFonts.figtree(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           SizedBox(height: Get.height * 0.03),
//           CustomButton(
//             ontap: () {},
//             isLoading: false.obs,
//             child: Text(
//               'Get Started',
//               style: GoogleFonts.figtree(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           SizedBox(height: Get.height * 0.02),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.info_outline, size: 16),
//               SizedBox(width: 5),
//               Text(
//                 'You get 7 days free trial',
//                 style: GoogleFonts.figtree(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.info_outline, size: 16),
//               SizedBox(width: 5),
//               Text(
//                 'You get 7 days free trial',
//                 style: GoogleFonts.figtree(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.info_outline, size: 16),
//               SizedBox(width: 5),
//               Text(
//                 'You get 7 days free trial',
//                 style: GoogleFonts.figtree(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.info_outline, size: 16),
//               SizedBox(width: 5),
//               Text(
//                 'You get 7 days free trial',
//                 style: GoogleFonts.figtree(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class SubscriptionPlan {
  final String id;
  final String duration;
  final String pricePerWeek;
  final String totalPrice;
  final String? savingsPercent;
  final int durationValue; // for sorting

  SubscriptionPlan({
    required this.id,
    required this.duration,
    required this.pricePerWeek,
    required this.totalPrice,
    this.savingsPercent,
    required this.durationValue,
  });
}

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedPlanIndex = 1; // Default to 1 month plan

  final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      id: "1week",
      duration: '1 week',
      pricePerWeek: '\$14.99/week',
      totalPrice: '\$14.99',
      durationValue: 1,
    ),
    SubscriptionPlan(
      id: "1month",
      duration: '1 month',
      pricePerWeek: '\$4.99/week',
      totalPrice: '\$19.99',
      savingsPercent: 'Save 66%',
      durationValue: 4,
    ),
    SubscriptionPlan(
      id: "3months",
      duration: '3 months',
      pricePerWeek: '\$3.33/week',
      totalPrice: '\$39.99',
      savingsPercent: 'Save 77%',
      durationValue: 12,
    ),
    SubscriptionPlan(
      id: "1year",
      duration: '1 year',
      pricePerWeek: '\$1.53/week',
      totalPrice: '\$79.99',
      savingsPercent: 'Save 89%',
      durationValue: 52,
    ),
  ];

  final List<String> features = [
    'Unlimited Likes',
    'Rewind your last swipe',
    'First Look at new members',
    'See extended profiles',
    'See matches and who likes you',
    'Ad-free experience',
  ];
  final subscriptionController = Get.find<SubscriptionController>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            size: 28,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Premium Matches, Premium Love',
                            style: GoogleFonts.figtree(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'pick the best plan for you!',
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Get.isDarkMode
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Plan Selection Section
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        'Select your plan',
                        style: GoogleFonts.figtree(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Horizontal Scrollable Plans
                    SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: plans.length,
                        itemBuilder: (context, index) {
                          return _buildPlanCard(index);
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Features Section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? AppColors.darkButtonColor
                            : AppColors.lightButtonColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Get.isDarkMode
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black.withOpacity(0.05),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Included with ${plans[selectedPlanIndex].duration.split(' ')[0]} ${plans[selectedPlanIndex].duration.split(' ')[1]} Plus',
                            style: GoogleFonts.figtree(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ...features.map(
                            (feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: AppColors.primaryColor,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: GoogleFonts.figtree(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Terms Text
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.figtree(
                          fontSize: 12,
                          color: Get.isDarkMode
                              ? Colors.white60
                              : Colors.black54,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Recurring billing. Cancel anytime. ',
                          ),
                          const TextSpan(
                            text:
                                'By tapping "Get Plus", you will be charged now, your subscription will auto-renew for the same price and plan length until you cancel via account management page, and you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms',
                            style: GoogleFonts.figtree(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),

                  // Get Plus Button
                  Obx(() {
                    if (userController.user.value == null) {
                      return SizedBox.shrink();
                    }

                    final status =
                        userController.user.value?.subscription?.status ?? "";
                    return Opacity(
                      opacity: status == "active" ? 0.3 : 1.0,
                      child: CustomButton(
                        ontap: () async {
                          if(status == "active") return;
                          await subscriptionController.createSubscription(
                            planId: plans[selectedPlanIndex].id,
                          );
                        },
                        isLoading: false.obs,
                        child: Text(
                          'Get Plus for ${plans[selectedPlanIndex].totalPrice} total',
                          style: GoogleFonts.figtree(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(int index) {
    final plan = plans[index];
    final isSelected = selectedPlanIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlanIndex = index;
        });
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (Get.isDarkMode
                    ? const Color(0xFFFFD4D2)
                    : const Color(0xFFFFD4D2))
              : (Get.isDarkMode
                    ? AppColors.darkButtonColor
                    : AppColors.lightButtonColor),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.black
                : (Get.isDarkMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1)),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Savings Badge
            if (plan.savingsPercent != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  plan.savingsPercent!,
                  style: GoogleFonts.figtree(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              const SizedBox(height: 24),

            // Duration
            Text(
              plan.duration,
              style: GoogleFonts.figtree(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.black : null,
              ),
            ),

            // Price
            Text(
              plan.pricePerWeek,
              style: GoogleFonts.figtree(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.black87
                    : (Get.isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

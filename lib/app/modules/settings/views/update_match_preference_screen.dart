// ignore_for_file: invalid_use_of_protected_member

import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateMatchPreferenceScreen extends StatefulWidget {
  const UpdateMatchPreferenceScreen({super.key});

  @override
  State<UpdateMatchPreferenceScreen> createState() =>
      _UpdateMatchPreferenceScreenState();
}

class _UpdateMatchPreferenceScreenState
    extends State<UpdateMatchPreferenceScreen> {
  final userController = Get.find<UserController>();

  final RxList<int> ageRange = <int>[].obs;
  final RxDouble maxDistance = 1.0.obs;
  // final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userModel = userController.user.value;
      if (userModel == null) return;
      ageRange.value = [
        (userModel.preference?.minAge ?? 18).toInt(),
        (userModel.preference?.maxAge ?? 65).toInt(),
      ];
      maxDistance.value = double.parse(
        userModel.preference?.maxDistance?.toString() ?? "50.0",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.primaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text('Match Preferences', style: theme.textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                'Customize Your Matches',
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 8),
              Text(
                'Set your preferences to find the perfect match',
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 40),

              // Age Range Section
              _buildSectionCard(
                isDark: isDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Age Range',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAgeChip(
                          ageRange.value.isNotEmpty
                              ? ageRange.value[0].toString()
                              : '18',
                          isDark,
                        ),
                        Text('to', style: theme.textTheme.bodySmall),
                        _buildAgeChip(
                          ageRange.value.length > 1
                              ? ageRange.value[1].toString()
                              : '65',
                          isDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: AppColors.primaryColor,
                        inactiveTrackColor: AppColors.primaryColor.withOpacity(
                          0.2,
                        ),
                        thumbColor: AppColors.primaryColor,
                        overlayColor: AppColors.primaryColor.withOpacity(0.2),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 24,
                        ),
                        rangeThumbShape: const RoundRangeSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                      ),
                      child: RangeSlider(
                        values: RangeValues(
                          ageRange.value.isNotEmpty
                              ? ageRange.value[0].toDouble()
                              : 18,
                          ageRange.value.length > 1
                              ? ageRange.value[1].toDouble()
                              : 65,
                        ),
                        min: 18,
                        max: 80,
                        divisions: 62,
                        onChanged: (RangeValues values) {
                          ageRange.value = [
                            values.start.round(),
                            values.end.round(),
                          ];
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Distance Section
              _buildSectionCard(
                isDark: isDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Maximum Distance',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        // decoration: BoxDecoration(
                        //   gradient: const LinearGradient(
                        //     colors: [
                        //       AppColors.senderStart,
                        //       AppColors.senderEnd,
                        //     ],
                        //   ),
                        //   borderRadius: BorderRadius.circular(30),
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: AppColors.primaryColor.withOpacity(0.3),
                        //       blurRadius: 12,
                        //       offset: const Offset(0, 4),
                        //     ),
                        //   ],
                        // ),
                        child: Text(
                          '${maxDistance.value.round()} km',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: AppColors.primaryColor,
                        inactiveTrackColor: AppColors.primaryColor.withOpacity(
                          0.2,
                        ),
                        thumbColor: AppColors.primaryColor,
                        overlayColor: AppColors.primaryColor.withOpacity(0.2),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 24,
                        ),
                      ),
                      child: Slider(
                        value: maxDistance.value,
                        min: 1,
                        max: 200,
                        divisions: 199,
                        onChanged: (value) {
                          maxDistance.value = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1 km', style: theme.textTheme.bodySmall),
                        Text('200 km', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Save Button
              CustomButton(
                ontap: () async {
                  await userController.updateMatchPreference(
                    ageRange: ageRange,
                    maxDistance: maxDistance.value.toInt(),
                  );
                },
                isLoading: userController.isloading,
                child: Text(
                  'Save Preferences',
                  style: GoogleFonts.figtree(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Info Text
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'These preferences help us show you the most relevant matches',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required bool isDark, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkButtonColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: child,
    );
  }

  Widget _buildAgeChip(String age, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.1)
            : AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
      ),
      child: Text(
        '$age years',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

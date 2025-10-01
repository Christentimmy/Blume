import 'dart:ui';

import 'package:get/get.dart';

class AppColors {
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color darkBackground = Color(0xFF121212);

  static const Color primaryColor = Color(0xFFFD504A);
  static Color secondaryColor = Get.isDarkMode ? Color(0xFFF2C2C2C) : Color(0xFFE6E6E6);
  static const Color textFormField = Color(0xFF000000);

  static const Color darkButtonColor = Color.fromRGBO(255, 255, 255, 0.05);
  static const Color lightButtonColor = Color.fromRGBO(0, 0, 0, 0.05);
}


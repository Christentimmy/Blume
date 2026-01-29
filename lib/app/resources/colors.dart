
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color darkBackground = Color(0xFF121212);

  static const Color primaryColor = Color(0xFFFD504A);
  static Color secondaryColor = Get.isDarkMode
      ? Color(0xFFF2C2C2C)
      : Color(0xFFE6E6E6);
  static const Color textFormField = Color(0xFF000000);

  static const Color darkButtonColor = Color.fromRGBO(255, 255, 255, 0.05);
  static const Color lightButtonColor = Color.fromRGBO(0, 0, 0, 0.05);

  // Sender (your messages)
  static const Color senderStart = Color(0xFFFF6B35);
  static const Color senderEnd = Color(0xFFF7931E);
  static const Color senderText = Colors.white;

  // Receiver (other person's messages)
  static const Color receiverBackground = Color(0xFFF1F3F4);
  static const Color receiverBorder = Color(0xFFE1E5E9);
  static const Color receiverText = Color(0xFF2C3E50);

  // Chat background
  static const Color chatBackground = Color(0xFFF8F9FA);

  // 🎯 NEW: Highlight colors for reply feature
  static const Color senderHighlightStart = Color(0xFFFF8A65);
  static const Color senderHighlightEnd = Color(0xFFFFB74D);
  static const Color senderHighlightShadow = Color(0x66FF8A65);

  static const Color receiverHighlightBackground = Color(0xFFFFF8E1);
  static const Color receiverHighlightBorder = Color(0xFFFFD54F);
  static const Color receiverHighlightShadow = Color(0x4DFFD54F);

  static Color lightGrey = const Color(0xFFF5F5F5);
}

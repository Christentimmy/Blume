import 'package:blume/app/controller/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';


class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final String key = 'isDarkMode';

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPreferences();
  }

  Future<void> _loadThemeFromPreferences() async {
    final storageController = Get.find<StorageController>();
    final theme = await storageController.getTheme();
    isDarkMode.value = theme == 'dark';
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _saveThemeToPreferences(bool isDarkMode) async {
    final storageController = Get.find<StorageController>();
    await storageController.storeTheme(isDarkMode ? 'dark' : 'light');
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _saveThemeToPreferences(isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
import 'package:blume/app/controller/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  final String key = 'isDarkMode';

  Future<void> loadThemeFromPreferences() async {
    final storageController = Get.put(StorageController());
    final theme = await storageController.getTheme();
    isDarkMode.value = theme == 'dark';
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _saveThemeToPreferences(bool isDarkMode) async {
    final storageController = Get.find<StorageController>();
    await storageController.storeTheme(isDarkMode ? 'dark' : 'light');
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    await _saveThemeToPreferences(isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}

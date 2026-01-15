import 'package:blume/app/bindings/app_bindings.dart';
import 'package:blume/app/controller/theme_controller.dart';
import 'package:blume/app/routes/app_pages.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize("2fa250e8-3569-45a5-9c27-db2be9b84c36");
  final themeController = Get.put(ThemeController());
  themeController.loadThemeFromPreferences();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Blume',
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        initialBinding: AppBindings(),
      ),
    );
  }
}

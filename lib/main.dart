import 'package:blume/app/bindings/app_bindings.dart';
import 'package:blume/app/routes/app_pages.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blume',
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
    );
  }
}

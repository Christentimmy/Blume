


import 'package:blume/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:blume/app/modules/splash/views/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingScreen()),
    // GetPage(name: AppRoutes.login, page: () => LoginScreen()),
  ];
}




import 'package:blume/app/modules/auth/views/login_screen.dart';
import 'package:blume/app/modules/auth/views/otp_verify_screen.dart';
import 'package:blume/app/modules/auth/views/signup_screen.dart';
import 'package:blume/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:blume/app/modules/profile/views/update_dob_screen.dart';
import 'package:blume/app/modules/profile/views/update_gender_screen.dart';
import 'package:blume/app/modules/profile/views/update_name_screen.dart';
import 'package:blume/app/modules/splash/views/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.otpVerify, page: () => OtpVerifyScreen()),
    GetPage(name: AppRoutes.updateName, page: () => UpdateNameScreen()),
    GetPage(name: AppRoutes.updateDob, page: () => UpdateDobScreen()),
    GetPage(name: AppRoutes.updateGender, page: () => UpdateGenderScreen()),
  ];
}

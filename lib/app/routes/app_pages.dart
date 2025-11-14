import 'dart:ui';

import 'package:blume/app/modules/auth/views/login_screen.dart';
import 'package:blume/app/modules/auth/views/otp_verify_screen.dart';
import 'package:blume/app/modules/auth/views/signup_screen.dart';
import 'package:blume/app/modules/home/views/home_screen.dart';
import 'package:blume/app/modules/home/views/match_screen.dart';
import 'package:blume/app/modules/likes/views/likes_screen.dart';
import 'package:blume/app/modules/location/views/set_location_screen.dart';
import 'package:blume/app/modules/messages/views/audio_call_screen.dart';
import 'package:blume/app/modules/messages/views/chat_list_screen.dart';
import 'package:blume/app/modules/messages/views/message_screen.dart';
import 'package:blume/app/modules/messages/views/video_call_screen.dart';
import 'package:blume/app/modules/notification/views/notification_screen.dart';
import 'package:blume/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:blume/app/modules/profile/views/add_pictures_screen.dart';
import 'package:blume/app/modules/profile/views/bio_screen.dart';
import 'package:blume/app/modules/profile/views/choose_boost_plan_screen.dart';
import 'package:blume/app/modules/profile/views/distance_preference_screen.dart';
import 'package:blume/app/modules/profile/views/interest_screen.dart';
import 'package:blume/app/modules/profile/views/lifestyle_screen.dart';
import 'package:blume/app/modules/profile/views/profile_screen.dart';
import 'package:blume/app/modules/profile/views/quiz_match_screen.dart';
import 'package:blume/app/modules/profile/views/relationship_preference_screen.dart';
import 'package:blume/app/modules/profile/views/religion_work_screen.dart';
import 'package:blume/app/modules/profile/views/update_dob_screen.dart';
import 'package:blume/app/modules/profile/views/update_gender_screen.dart';
import 'package:blume/app/modules/profile/views/update_name_screen.dart';
import 'package:blume/app/modules/search/views/search_screen.dart';
import 'package:blume/app/modules/settings/views/settings_screen.dart';
import 'package:blume/app/modules/splash/views/splash_screen.dart';
import 'package:blume/app/modules/story/views/view_story_screen.dart';
import 'package:blume/app/modules/subscription/views/subscription_screen.dart';
import 'package:blume/app/modules/verification/views/disclaimer_screen.dart';
import 'package:blume/app/modules/verification/views/verification_screen.dart';
import 'package:blume/app/widgets/bottom_navigation_widget.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignUpScreen()),
    GetPage(
      name: AppRoutes.otpVerify,
      page: () {
        final arguments = Get.arguments ?? {};
        String email = arguments["email"] as String;
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        if (email.isEmpty) {
          throw Exception("Email is required");
        }
        return OtpVerifyScreen(email: email, whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.updateName,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return UpdateNameScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.updateDob,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return UpdateDobScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.updateGender,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return UpdateGenderScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.relationshipPreference,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return RelationshipPreferenceScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.distancePreference,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return DistancePreferenceScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.bio,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return BioScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.lifestyle,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return LifeStyleScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.religionWork,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return ReligionWorkScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.interest,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return InterestScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.addPictures,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return AddPicturesScreen(whatNext: whatNext);
      },
    ),
    GetPage(
      name: AppRoutes.setLocation,
      page: () {
        final arguments = Get.arguments ?? {};
        VoidCallback? whatNext = arguments["whatNext"] as VoidCallback?;
        return SetLocationScreen(whatNext: whatNext);
      },
    ),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(
      name: AppRoutes.match,
      page: () {
        final arguments = Get.arguments ?? {};
        final targetUserId = arguments['targetUserId'] as String;
        if (targetUserId.isEmpty) {
          throw Exception("User ID is required");
        }
        return MatchScreen(targetUserId: targetUserId);
      },
    ),
    GetPage(name: AppRoutes.notification, page: () => NotificationScreen()),
    GetPage(name: AppRoutes.search, page: () => SearchScreen()),
    GetPage(name: AppRoutes.likes, page: () => LikesScreen()),
    GetPage(name: AppRoutes.chatList, page: () => ChatListScreen()),
    GetPage(name: AppRoutes.viewStory, page: () => ViewStoryScreen()),
    GetPage(name: AppRoutes.message, page: () => MessageScreen()),
    GetPage(name: AppRoutes.audioCall, page: () => AudioCallScreen()),
    GetPage(name: AppRoutes.videoCall, page: () => VideoCallScreen()),
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.settings, page: () => SettingsScreen()),
    GetPage(name: AppRoutes.disclaimer, page: () => DisclaimerScreen()),
    GetPage(name: AppRoutes.verification, page: () => VerificationScreen()),
    GetPage(name: AppRoutes.subscription, page: () => SubscriptionScreen()),
    GetPage(
      name: AppRoutes.bottomNavigation,
      page: () => BottomNavigationWidget(),
    ),
    GetPage(name: AppRoutes.quizMatch, page: () => QuizMatchScreen()),
    GetPage(
      name: AppRoutes.chooseBoostPlan,
      page: () => ChooseBoostPlanScreen(),
    ),
  ];
}

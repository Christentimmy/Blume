import 'package:blume/app/modules/auth/views/login_screen.dart';
import 'package:blume/app/modules/auth/views/otp_verify_screen.dart';
import 'package:blume/app/modules/auth/views/signup_screen.dart';
import 'package:blume/app/modules/home/views/home_screen.dart';
import 'package:blume/app/modules/home/views/match_screen.dart';
import 'package:blume/app/modules/likes/views/likes_screen.dart';
import 'package:blume/app/modules/location/views/set_location_screen.dart';
import 'package:blume/app/modules/messages/views/chat_list_screen.dart';
import 'package:blume/app/modules/notification/views/notification_screen.dart';
import 'package:blume/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:blume/app/modules/profile/views/add_pictures_screen.dart';
import 'package:blume/app/modules/profile/views/distance_preference_screen.dart';
import 'package:blume/app/modules/profile/views/education_screen.dart';
import 'package:blume/app/modules/profile/views/interest_screen.dart';
import 'package:blume/app/modules/profile/views/lifestyle_screen.dart';
import 'package:blume/app/modules/profile/views/relationship_preference_screen.dart';
import 'package:blume/app/modules/profile/views/religion_work_screen.dart';
import 'package:blume/app/modules/profile/views/update_dob_screen.dart';
import 'package:blume/app/modules/profile/views/update_gender_screen.dart';
import 'package:blume/app/modules/profile/views/update_name_screen.dart';
import 'package:blume/app/modules/search/views/search_screen.dart';
import 'package:blume/app/modules/splash/views/splash_screen.dart';
import 'package:blume/app/modules/story/views/view_story_screen.dart';
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
    GetPage(name: AppRoutes.relationshipPreference, page: () => RelationshipPreferenceScreen()),
    GetPage(name: AppRoutes.distancePreference, page: () => DistancePreferenceScreen()),
    GetPage(name: AppRoutes.education, page: () => EducationScreen()),
    GetPage(name: AppRoutes.lifestyle, page: () => LifeStyleScreen()),
    GetPage(name: AppRoutes.religionWork, page: () => ReligionWorkScreen()),
    GetPage(name: AppRoutes.interest, page: () => InterestScreen()),
    GetPage(name: AppRoutes.addPictures, page: () => AddPicturesScreen()),
    GetPage(name: AppRoutes.setLocation, page: () => SetLocationScreen()),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(name: AppRoutes.match, page: () => MatchScreen()),
    GetPage(name: AppRoutes.notification, page: () => NotificationScreen()),
    GetPage(name: AppRoutes.search, page: () => SearchScreen()),
    GetPage(name: AppRoutes.likes, page: () => LikesScreen()),
    GetPage(name: AppRoutes.chatList, page: () => ChatListScreen()),
    GetPage(name: AppRoutes.viewStory, page: () => ViewStoryScreen()),
  ];
}

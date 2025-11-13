import 'dart:convert';

import 'package:blume/app/controller/storage_controller.dart';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/services/auth_service.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthService authService = AuthService();
  final isloading = false.obs;
  final isOtpVerifyLoading = false.obs;

  Future<void> register({
    required String email,
    required String phone,
    required String password,
  }) async {
    isloading.value = true;
    try {
      final response = await authService.register(
        email: email,
        phone: phone,
        password: password,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"];
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final storage = Get.find<StorageController>();
      final token = decoded["token"];
      await storage.storeToken(token);

      Get.toNamed(AppRoutes.otpVerify, arguments: {"email": email});
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> verifyOtp({
    required String otpCode,
    required String email,
    VoidCallback? whatNext,
  }) async {
    isOtpVerifyLoading.value = true;
    try {
      final response = await authService.verifyOtp(
        otpCode: otpCode,
        email: email,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      if (whatNext != null) {
        whatNext();
        return;
      }

      Get.offNamed(AppRoutes.updateName);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isOtpVerifyLoading.value = false;
    }
  }

  Future<void> sendOtp({required String email}) async {
    isloading.value = true;
    try {
      final response = await authService.sendOtp(email: email);
      if (response == null) return;

      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast("Failed to get OTP, $message");
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> loginUser({
    required String identifier,
    required String password,
  }) async {
    isloading.value = true;
    try {
      final response = await authService.loginUser(
        identifier: identifier,
        password: password,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      String token = decoded["token"] ?? "";

      final storageController = Get.find<StorageController>();
      await storageController.storeToken(token);

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      // final userController = Get.find<UserController>();
      // final storyController = Get.find<StoryController>();
      // await userController.getUserDetails();
      // await userController.getPotentialMatches();
      // final socketController = Get.find<SocketController>();
      // socketController.initializeSocket();
      await handleNavigation();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> handleNavigation() async {
    final userController = Get.find<UserController>();
    await userController.getUserDetails();
    final userModel = userController.user.value;
    if (userModel == null) {
      Get.offNamed(AppRoutes.onboarding);
      return;
    }
    if (userModel.fullName == null || userModel.fullName!.isEmpty) {
      Get.offNamed(AppRoutes.updateName, arguments: {
        "whatNext": () async {
          await handleNavigation();
        }
      });
      return;
    }
    if (userModel.dateOfBirth == null || userModel.dateOfBirth!.isEmpty) {
      Get.offNamed(AppRoutes.updateDob, arguments: {
        "whatNext": () async {
          await handleNavigation();
        }
      });
      return;
    }
    if (userModel.gender == null || userModel.gender!.isEmpty) {
      Get.offNamed(AppRoutes.updateGender, arguments: {
        "whatNext": () async {
          await handleNavigation();
        }
      });
      return;
    }
    if (userModel.interestedIn == null || userModel.interestedIn!.isEmpty) {
      Get.offNamed(AppRoutes.relationshipPreference, arguments: {
        "whatNext": () async {
          await handleNavigation();
        }
      });
      return;
    }
    if (userModel.preference?.maxDistance == null || userModel.preference?.maxDistance == 0) {
      Get.offNamed(AppRoutes.distancePreference, arguments: {
        "whatNext": () async {
          await handleNavigation();
        }
      });
      return;
    }
    // if (userModel.education == null || userModel.education!.isEmpty) {
    //   Get.offNamed(AppRoutes.education, arguments: {
    //     "whatNext": () async {
    //       await handleNavigation();
    //     }
    //   });
    //   return;
    // }
    if (userModel.photos?.isEmpty ?? true) {
      Get.offNamed(AppRoutes.addPictures, arguments: {
        "whatNext": () async {
          await handleNavigation();
        }
      });
      return;
    }
    if(userModel.location == null || userModel.location!.isEmpty) {
      Get.offNamed(AppRoutes.setLocation, arguments: {
        "whatNext": () async {
          await handleNavigation();
        }
      });
      return;
    }
    Get.offNamed(AppRoutes.bottomNavigation);
  }

}

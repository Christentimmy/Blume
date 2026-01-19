import 'dart:convert';
import 'package:blume/app/controller/message_controller.dart';
import 'package:blume/app/controller/socket_controller.dart';
import 'package:blume/app/controller/storage_controller.dart';
import 'package:blume/app/controller/subscription_controller.dart';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/services/auth_service.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthController extends GetxController {
  AuthService authService = AuthService();
  final isloading = false.obs;
  final isOtpVerifyLoading = false.obs;

  final TextEditingController emailController = TextEditingController();

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
      final userController = Get.find<UserController>();
      // final storyController = Get.find<StoryController>();
      await userController.getUserDetails();
      await userController.getPotentialMatches();
      final socketController = Get.find<SocketController>();
      socketController.initializeSocket();
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
      Get.offNamed(
        AppRoutes.updateName,
        arguments: {
          "whatNext": () async {
            await handleNavigation();
          },
        },
      );
      return;
    }
    if (userModel.dateOfBirth == null || userModel.dateOfBirth!.isEmpty) {
      Get.offNamed(
        AppRoutes.updateDob,
        arguments: {
          "whatNext": () async {
            await handleNavigation();
          },
        },
      );
      return;
    }
    if (userModel.gender == null || userModel.gender!.isEmpty) {
      Get.offNamed(
        AppRoutes.updateGender,
        arguments: {
          "whatNext": () async {
            await handleNavigation();
          },
        },
      );
      return;
    }
    if (userModel.interestedIn == null || userModel.interestedIn!.isEmpty) {
      Get.offNamed(
        AppRoutes.relationshipPreference,
        arguments: {
          "whatNext": () async {
            await handleNavigation();
          },
        },
      );
      return;
    }
    if (userModel.preference?.maxDistance == null ||
        userModel.preference?.maxDistance == 0) {
      Get.offNamed(
        AppRoutes.distancePreference,
        arguments: {
          "whatNext": () async {
            await handleNavigation();
          },
        },
      );
      return;
    }
    if (userModel.bio == null || userModel.bio!.isEmpty) {
      Get.offNamed(
        AppRoutes.bio,
        arguments: {
          "whatNext": () async {
            await handleNavigation();
          },
        },
      );
      return;
    }
    if (userModel.photos?.isEmpty ?? true) {
      Get.offNamed(
        AppRoutes.addPictures,
        arguments: {
          "whatNext": () async {
            await handleNavigation();
          },
        },
      );
      return;
    }
    if (userModel.location == null || userModel.location!.isEmpty) {
      Get.offNamed(
        AppRoutes.setLocation,
        arguments: {
          "whatNext": () async {
            await handleNavigation();
          },
        },
      );
      return;
    }
    final socketController = Get.find<SocketController>();
    await socketController.initializeSocket();
    Get.offNamed(AppRoutes.bottomNavigation);
  }

  Future<void> logout() async {
    try {
      Get.offAllNamed(AppRoutes.login);
      String? token = await StorageController().getToken();
      if (token == null) {
        return;
      }

      final response = await authService.logout(token: token);
      if (response == null) return;
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        debugPrint(data["message"].toString());
        return;
      }

      Get.find<UserController>().clearUserData();
      await Get.find<StorageController>().deleteToken();
      await Get.find<MessageController>().clearChatHistory();
      Get.find<SocketController>().disconnectSocket();
      await Get.find<SubscriptionController>().clearSubscriptionData();
      // await Get.find<InviteController>().clearInviteData();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void showForgotPasswordDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        title: Text(
          "Forgot Password?",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enter your email address and we'll send you an OTP to reset your password.",
              style: GoogleFonts.fredoka(fontSize: 13),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: emailController,
              hintText: "Enter your email",
              prefixIconColor: AppColors.primaryColor,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 45,
            width: 140,
            child: CustomButton(
              ontap: () async {
                if (emailController.text.isEmpty) {
                  CustomSnackbar.showErrorToast(
                    "Please enter your email address",
                  );
                  return;
                }
                await sendOtp(email: emailController.text);
                Get.toNamed(
                  AppRoutes.otpVerify,
                  arguments: {
                    "email": emailController.text,
                    "whatNext": () async {
                      Get.toNamed(
                        AppRoutes.resetPassword,
                        arguments: {"email": emailController.text},
                      );
                    },
                    "showEditDetails": false,
                  },
                );
              },
              isLoading: isloading,
              child: Text(
                "Send",
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final String? token = await storageController.getToken();
      if (token == null) return;

      final response = await authService.changePassword(
        token: token,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      await logout();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
  }) async {
    isloading.value = true;
    try {
      final response = await authService.resetPassword(
        email: email,
        password: password,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}

import 'dart:convert';

import 'package:blume/app/controller/storage_controller.dart';
import 'package:blume/app/data/services/auth_service.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthService authService = AuthService();
  final isloading = false.obs;

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
      if (response.statusCode != 200) {
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
}

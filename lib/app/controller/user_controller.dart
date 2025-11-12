import 'dart:convert';
import 'package:blume/app/controller/storage_controller.dart';
import 'package:blume/app/data/services/use_service.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final isloading = false.obs;
  final userService = UserService();

  Future<void> updateName({
    required String name,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await userService.updateName(token: token, name: name);
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
      Get.toNamed(AppRoutes.updateDob);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateDob({
    required DateTime dob,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await userService.updateDob(token: token, dob: dob);
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
      Get.toNamed(AppRoutes.updateGender);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateGender({
    required String gender,
    required bool showGender,
    required VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await userService.updateGender(
        token: token,
        gender: gender,
        showGender: showGender,
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
      Get.toNamed(AppRoutes.relationshipPreference);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updatePreference({
    required String preference,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;

      final response = await userService.updatePreference(
        token: token,
        preference: preference,
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
      Get.toNamed(AppRoutes.distancePreference);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> distancePreference({
    required double distance,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await userService.distancePreference(
        token: token,
        distance: distance,
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
      Get.toNamed(AppRoutes.education);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateEducation({
    required String education,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await userService.updateEducation(
        token: token,
        education: education,
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
      Get.toNamed(AppRoutes.lifestyle);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateLifestyle({
    required String smoking,
    required String drinking,
    required String workout,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;

      final response = await userService.updateLifestyle(
        token: token,
        smoking: smoking,
        drinking: drinking,
        workout: workout,
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
      Get.toNamed(AppRoutes.religionWork);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  

}

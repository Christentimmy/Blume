import 'dart:convert';
import 'package:blume/app/controller/storage_controller.dart';
import 'package:blume/app/data/services/boost_service.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/utils/url_launcher.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostController extends GetxController {
  final _boostService = BoostService();
  final isloading = false.obs;

  Future<void> purchaseBoost({required String boostType}) async {
    isloading.value = true;
    try {
      final token = await Get.find<StorageController>().getToken();
      if (token == null) {
        Get.toNamed(AppRoutes.login);
        return;
      }

      final response = await _boostService.purchaseBoost(
        token: token,
        boostType: boostType,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded['message'];
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      final url = decoded["url"];
      if (url == null) {
        CustomSnackbar.showErrorToast("Url not found");
        return;
      }

      await urlLauncher(url);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }
}

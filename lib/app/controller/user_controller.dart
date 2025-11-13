import 'dart:convert';
import 'dart:io';
import 'package:appinio_swiper/enums.dart';
import 'package:blume/app/controller/storage_controller.dart';
import 'package:blume/app/data/models/user_model.dart';
import 'package:blume/app/data/services/user_service.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final isloading = false.obs;
  final userService = UserService();
  final Rxn<UserModel> user = Rxn<UserModel>();

  //potential matches variables
  RxList<UserModel> potentialMatchesList = <UserModel>[].obs;
  RxInt currentPage = 1.obs;
  RxBool hasNextPage = false.obs;

  RxList<UserModel> usersWhoLikesMeList = <UserModel>[].obs;

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

  Future<void> updateDob({required String dob, VoidCallback? whatNext}) async {
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

  Future<void> updateBasic({
    required String occupation,
    required String religion,
    String? education,
    String? height,
    String? sexualOrientation,
    List<String>? languagesSpoken,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;

      final response = await userService.updateBasic(
        token: token,
        occupation: occupation,
        religion: religion,
        education: education,
        height: height,
        sexualOrientation: sexualOrientation,
        languagesSpoken: languagesSpoken,
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
      Get.toNamed(AppRoutes.interest);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateBasic2({
    List<String>? lifestyleAndValues,
    List<String>? hobbies,
    List<String>? artsAndCreativity,
    List<String>? sportsAndFitness,
    List<String>? travelAndAdventure,
    List<String>? entertainment,
    List<String>? music,
    List<String>? foodAndDrink,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;

      final response = await userService.updateBasic2(
        token: token,
        lifestyleAndValues: lifestyleAndValues,
        hobbies: hobbies,
        artsAndCreativity: artsAndCreativity,
        sportsAndFitness: sportsAndFitness,
        travelAndAdventure: travelAndAdventure,
        entertainment: entertainment,
        music: music,
        foodAndDrink: foodAndDrink,
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

      Get.toNamed(AppRoutes.addPictures);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> addPhotoToGallery({
    required List<File> imageFiles,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await userService.addPhotoToGallery(
        token: token,
        imageFiles: imageFiles,
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

      Get.toNamed(AppRoutes.setLocation);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> updateLocation({
    required double latitude,
    required double longitude,
    required String address,
    VoidCallback? whatNext,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) return;
      final response = await userService.updateLocation(
        token: token,
        latitude: latitude,
        longitude: longitude,
        address: address,
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

      Get.toNamed(AppRoutes.bottomNavigation);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getUserDetails() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) {
        Get.offNamed(AppRoutes.login);
        return;
      }
      final response = await userService.getUserDetails(token: token);
      if (response == null) {
        Get.offNamed(AppRoutes.login);
        return;
      }
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final user = UserModel.fromJson(decoded["data"] ?? {});
      this.user.value = user;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getPotentialMatches({
    bool? loadMore = false,
    bool showLoader = true,
  }) async {
    isloading.value = showLoader;

    try {
      if (loadMore == true && hasNextPage.value) {
        currentPage.value++;
      } else {
        currentPage.value = 1;
        potentialMatchesList.clear();
      }
      await Future.delayed(const Duration(seconds: 1));

      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await userService.getPotentialMatches(
        token: token,
        page: currentPage.value,
      );

      if (response == null) return;

      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        debugPrint(decoded["message"].toString());
        return;
      }

      List matches = decoded["data"] ?? [];
      hasNextPage.value = decoded["hasNextPage"] ?? false;
      if (matches.isEmpty) return;

      List<UserModel> mapped = matches
          .map((e) => UserModel.fromJson(e))
          .toList();
      if (loadMore == true && hasNextPage.value == true) {
        potentialMatchesList.addAll(mapped);
      } else {
        potentialMatchesList.value = mapped;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> swipe({required String userId, required SwipeType type}) async {
    try {
      removeUserFromPotentialList(userId);
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await userService.swipeLike(
        token: token,
        targetUserId: userId,
        type: type.name.toLowerCase(),
      );

      if (response == null) return;
      final decoded = json.decode(response.body);

      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(decoded["message"]);
        return;
      }

      final match = decoded["match"];
      if (match == null) return;

      String targetUserId = match["targetUserId"] ?? "";
      if (targetUserId.isEmpty) return;

      Get.toNamed(AppRoutes.match, arguments: {"targetUserId": targetUserId});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeUserFromPotentialList(String userId) {
    potentialMatchesList.removeWhere((element) => element.id == userId);
  }

  void onSwipeEnd(
    int previousIndex,
    int targetIndex,
    SwiperActivity activity,
  ) async {
    if (previousIndex == -1) return;
    if (previousIndex >= potentialMatchesList.length) {
      return;
    }
    final userId = potentialMatchesList[previousIndex].id;
    if (userId == null) return;
    if (activity.direction == AxisDirection.right) {
      await swipe(userId: userId, type: SwipeType.like);
    }
    if (activity.direction == AxisDirection.left) {
      await swipe(userId: userId, type: SwipeType.pass);
    }
    if (activity.direction == AxisDirection.up) {
      await swipe(userId: userId, type: SwipeType.superlike);
    }
  }

  Future<UserModel?> getUserWithId({required String userId}) async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return null;
      }
      final response = await userService.getUserWithId(
        token: token,
        userId: userId,
      );
      if (response == null) return null;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        CustomSnackbar.showErrorToast(decoded["message"]);
        return null;
      }
      return UserModel.fromJson(decoded["data"]);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> getUserWhoLikesMe() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await userService.getUserWhoLikesMe(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        debugPrint(decoded["message"].toString());
        return;
      }
      List matches = decoded["data"] ?? [];
      if (matches.isEmpty) return;
      List<UserModel> mapped = matches
          .map((e) => UserModel.fromJson(e))
          .toList();
      usersWhoLikesMeList.value = mapped;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

    void clearUserData(){
      user.value = null;
      potentialMatchesList.clear();
      usersWhoLikesMeList.clear();
      currentPage.value = 1;
      hasNextPage.value = false;
      
    }

}

enum SwipeType { pass, superlike, like }

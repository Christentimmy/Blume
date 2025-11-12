import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:blume/app/utils/base_url.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<http.Response?> updateName({
    required String token,
    required String name,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/user/update-name"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({"full_name": name}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateDob({
    required String token,
    required String dob,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse("$baseUrl/user/update-dob"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({"date_of_birth": dob}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateGender({
    required String token,
    required String gender,
    required bool showGender,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse("$baseUrl/user/update-gender"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({"gender": gender, "showGender": showGender}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updatePreference({
    required String token,
    required String preference,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse("$baseUrl/user/update-preference"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({"relationship_preference": preference}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> distancePreference({
    required String token,
    required double distance,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse("$baseUrl/user/update-distance-preference"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({"distance": distance}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateEducation({
    required String token,
    required String education,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse("$baseUrl/user/update-education"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({"education": education}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateLifestyle({
    required String token,
    required String smoking,
    required String drinking,
    required String workout,
  }) async {
    try {
      final response = await http
          .patch(
            Uri.parse("$baseUrl/user/update-lifestyle"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({
              "smoking": smoking,
              "drinking": drinking,
              "workout": workout,
            }),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateBasic({
    required String token,
    required String occupation,
    required String religion,
    String? education,
    String? height,
    String? sexualOrientation,
    List<String>? languagesSpoken,
  }) async {
    Map body = {"occupation": occupation, "religion": religion};
    if (education != null) body["education"] = education;
    if (height != null) body["height"] = height;
    if (sexualOrientation != null) {
      body["sexOrientation"] = sexualOrientation;
    }
    if (languagesSpoken != null) {
      body["languages"] = languagesSpoken;
    }
    try {
      final response = await http
          .patch(
            Uri.parse("$baseUrl/user/update-basic"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateBasic2({
    required String token,
    String? lifestyleAndValues,
    String? hobbies,
    String? artsAndCreativity,
    String? sportsAndFitness,
    String? travelAndAdventure,
    String? entertainment,
    String? music,
    String? foodAndDrink,
  }) async {
    Map body = {};
    if (lifestyleAndValues != null)
      body["lifestyleAndValues"] = lifestyleAndValues;
    if (hobbies != null) body["hobbies"] = hobbies;
    if (artsAndCreativity != null)
      body["artsAndCreativity"] = artsAndCreativity;
    if (sportsAndFitness != null) body["sportsAndFitness"] = sportsAndFitness;
    if (travelAndAdventure != null)
      body["travelAndAdventure"] = travelAndAdventure;
    if (entertainment != null) body["entertainment"] = entertainment;
    if (music != null) body["music"] = music;
    if (foodAndDrink != null) body["foodAndDrink"] = foodAndDrink;
    try {
      final response = await http
          .patch(
            Uri.parse("$baseUrl/user/update-basic-2"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> addPhotoToGallery({
    required String token,
    required List<File> imageFiles,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/user/upload-dating-photos");

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data';

      final multipartFiles = await Future.wait(
        imageFiles.map(
          (file) async =>
              await http.MultipartFile.fromPath('photos', file.path),
        ),
      );

      request.files.addAll(multipartFiles);

      var response = await request.send().timeout(const Duration(seconds: 20));
      return await http.Response.fromStream(response);
    } on SocketException catch (e) {
      CustomSnackbar.showErrorToast("Check internet connection, $e");
      debugPrint("No internet connection");
      return null;
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateLocation({
    required String token,
    required double latitude,
    required double longitude,
    required String address,
  })async{
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/user/update-location"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "latitude": latitude,
          "longitude": longitude,
          "address": address,
        }),
      )
      .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

}

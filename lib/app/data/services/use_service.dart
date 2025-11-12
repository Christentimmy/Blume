import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blume/app/utils/base_url.dart';
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
    required DateTime dob,
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
}

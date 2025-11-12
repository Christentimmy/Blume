import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blume/app/utils/base_url.dart';
import 'package:blume/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<http.Response?> register({
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = http.post(
        Uri.parse("$baseUrl/auth/register"),
        body: {"email": email, "phone": phone, "password": password},
      );
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

  Future<http.Response?> verifyOtp({
    required String otpCode,
    required String email,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/auth/verify-otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "otp": otpCode}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<http.Response?> sendOtp({required String email}) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/auth/send-otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http
          .post(
            Uri.parse("$baseUrl/auth/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 15));

      return response;
    } on SocketException catch (_) {
      CustomSnackbar.showErrorToast("Host connection unstable");
      debugPrint("No internet connection");
      return null;
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
  }
}

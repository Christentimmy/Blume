import 'dart:async';
import 'dart:io';

import 'package:blume/app/utils/base_url.dart';
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
}

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

}

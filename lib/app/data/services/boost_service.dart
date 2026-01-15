import 'dart:convert';

import 'package:blume/app/utils/base_url.dart';
import 'package:blume/app/utils/safe_request.dart';
import 'package:http/http.dart' as http;

class BoostService {
  Future<http.Response?> purchaseBoost({
    required String token,
    required String boostType,
  }) {
    return safeRequest(() {
      return http.post(
        Uri.parse("$baseUrl/boost/purchase"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "boostType": boostType,
        }),
      );
    }, context: 'purchaseBoost');
  }
}

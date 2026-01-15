import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:blume/app/utils/base_url.dart';
import 'package:blume/app/utils/safe_request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubscriptionService {
  Future<http.Response?> createSubscription({
    required String token,
    required String planId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/subscriptions/create"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({"planId": planId}),
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

  Future<http.Response?> getSubscriptionPlans({required String token}) {
    return safeRequest(() {
      return http.get(
        Uri.parse("$baseUrl/subscription/plans"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'getSubscriptionPlans');
  }

  Future<http.Response?> cancelSubscription({required String token}) {
    return safeRequest(() {
      return http.post(
        Uri.parse("$baseUrl/subscription/cancel"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'cancelSubscription');
  }

  Future<http.Response?> reactivateUserSubscription({required String token}) {
    return safeRequest(() {
      return http.post(
        Uri.parse("$baseUrl/subscription/reactivate"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    }, context: 'reactivateUserSubscription');
  }

}

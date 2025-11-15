import 'package:blume/app/controller/auth_controller.dart';
import 'package:blume/app/controller/storage_controller.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> fadeAnimation;

  // final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: -50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.bounceOut),
      ),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () async {
      final authController = Get.find<AuthController>();
      final storageController = Get.find<StorageController>();
      final token = await storageController.getToken();
      if (token == null) {
        Get.offNamed(AppRoutes.onboarding);
        return;
      }
      await authController.handleNavigation();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _bounceAnimation.value),
              child: Opacity(
                opacity: fadeAnimation.value,
                child: Text(
                  "BLUME",
                  style: GoogleFonts.figtree(
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

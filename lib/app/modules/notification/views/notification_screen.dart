import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/data/models/notification_model.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.notificationList.isNotEmpty) return;
      userController.getNotifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text(
          "Notifications",
          style: GoogleFonts.figtree(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? AppColors.darkButtonColor
                        : AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Obx(() {
                    if (userController.isloading.value) {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }
                    if (userController.notificationList.isEmpty) {
                      return Center(
                        child: Text(
                          "No notifications",
                          style: GoogleFonts.figtree(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: userController.notificationList.length,
                      itemBuilder: (context, index) {
                        final notification =
                            userController.notificationList[index];
                        return buildNotificationCard(
                          notification: notification,
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildNotificationCard({required NotificationModel notification}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      horizontalTitleGap: 6,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Color(0xFF542C13),
        child: Text(
          "B",
          style: GoogleFonts.figtree(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        notification.message,
        style: GoogleFonts.figtree(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        DateFormat('hh:mm a').format(notification.createdAt),
        style: GoogleFonts.figtree(
          fontSize: 11,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400,
        ),
      ),
      // trailing: Icon(Icons.verified, color: Colors.blue),
    );
  }
}

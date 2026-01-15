import 'package:blume/app/controller/socket_controller.dart';
import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/modules/home/views/home_screen.dart';
import 'package:blume/app/modules/likes/views/likes_screen.dart';
import 'package:blume/app/modules/messages/views/chat_list_screen.dart';
import 'package:blume/app/modules/search/views/search_screen.dart';
import 'package:blume/app/modules/settings/views/settings_screen.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final List<Widget> widgets = [
    const HomeScreen(),
    const SearchScreen(),
    LikesScreen(),
    const ChatListScreen(),
    SettingsScreen(),
  ];

  final RxInt currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    final socketController = Get.find<SocketController>();
    if (socketController.socket == null ||
        !socketController.socket!.connected) {
      socketController.initializeSocket();
    }
    final userController = Get.find<UserController>();
    final user = userController.user.value;
    if (user == null) return;
    if (user.oneSignalId == null || user.oneSignalId!.isEmpty) {
      userController.saveUserOneSignalId();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => widgets[currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (value) => currentIndex.value = value,
          selectedItemColor: AppColors.primaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
    );
  }
}

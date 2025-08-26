import 'package:blume/app/modules/home/views/home_screen.dart';
import 'package:blume/app/modules/likes/views/likes_screen.dart';
import 'package:blume/app/modules/messages/views/chat_list_screen.dart';
import 'package:blume/app/modules/search/views/search_screen.dart';
import 'package:blume/app/modules/settings/views/settings_screen.dart';
import 'package:blume/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationWidget extends StatelessWidget {
  BottomNavigationWidget({super.key});

  final List<Widget> widgets = [
    const HomeScreen(),
    const SearchScreen(),
    LikesScreen(),
    const ChatListScreen(),
    SettingsScreen(),
  ];

  final RxInt currentIndex = 0.obs;

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

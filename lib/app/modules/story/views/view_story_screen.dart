import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ViewStoryScreen extends StatelessWidget {
  const ViewStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Image.asset("assets/images/cardd.png", fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(hintText: "Write something..."),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

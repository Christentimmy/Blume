import 'package:blume/app/resources/colors.dart';
import 'package:blume/app/routes/app_routes.dart';
import 'package:blume/app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/frm.png"),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jessica Baker",
                      style: GoogleFonts.figtree(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    Text(
                      "Active now",
                      style: GoogleFonts.figtree(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.audioCall),
            icon: Icon(Icons.call),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    buildReceiverCard(),
                    SizedBox(height: Get.height * 0.01),
                    buildSenderCard(),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Type something...",
                      suffixIcon: Icons.add,
                    ),
                  ),
                  SizedBox(width: 5),
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.primaryColor,
                    child: Transform.rotate(
                      angle: -0.4,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Align buildReceiverCard() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Get.isDarkMode
                    ? AppColors.darkButtonColor
                    : AppColors.lightButtonColor,
              ),
              child: Text(
                "Nice! I’m always looking for new spots. What’s the name?",
                softWrap: true,
                overflow: TextOverflow.visible,
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                "22:50",
                style: GoogleFonts.figtree(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align buildSenderCard() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width * 0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.primaryColor,
              ),
              child: Text(
                "It’s called Pine Ridge, gorgeous views and a waterfall at the end. Totally worth the climb.",
                softWrap: true,
                overflow: TextOverflow.visible,
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                "22:50",
                style: GoogleFonts.figtree(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Get.theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

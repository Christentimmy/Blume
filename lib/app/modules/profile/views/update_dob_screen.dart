import 'package:blume/app/controller/user_controller.dart';
import 'package:blume/app/modules/profile/widgets/date_widget.dart';
import 'package:blume/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateDobScreen extends StatelessWidget {
  final VoidCallback? whatNext;
  UpdateDobScreen({super.key, this.whatNext});

  final Rxn<String> selectedDate = Rxn<String>();
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "Birthday",
                style: GoogleFonts.figtree(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Your birthday is shown on your profile but not your date of birth",
                style: GoogleFonts.figtree(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              FunctionalDatePicker(
                onDateChanged: (date) {
                  selectedDate.value = date;
                },
              ),
              const Spacer(),
              CustomButton(
                ontap: () async {
                  if (selectedDate.value == null) return;
                  await userController.updateDob(
                    dob: selectedDate.value!,
                    whatNext: whatNext,
                  );
                },
                isLoading: userController.isloading,
                child: Text(
                  "Next",
                  style: GoogleFonts.figtree(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

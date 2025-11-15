
import 'package:blume/app/resources/colors.dart';
import 'package:flutter/material.dart';

BoxDecoration chatInputFieldDecoration({bool? showBorderRadius = true}) {
  return BoxDecoration(
    // color: Colors.black,
    borderRadius: showBorderRadius == false ? null : BorderRadius.circular(30),
    border: Border.all(color: AppColors.primaryColor, width: 1),
  );
}

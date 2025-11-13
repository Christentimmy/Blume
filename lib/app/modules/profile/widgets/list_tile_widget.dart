import 'package:blume/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Wrap buildOptions({
  required List<String> options,
  required RxInt selectedOption,
}) {
  return Wrap(
    runSpacing: 10,
    children: List.generate(
      options.length,
      (index) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Obx(
          () => InkWell(
            onTap: () => selectedOption.value = index,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: selectedOption.value == index
                    ? Border.all(color: AppColors.primaryColor)
                    : Border.all(color: Colors.grey),
                color: Colors.transparent,
              ),
              child: Text(
                options[index],
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: selectedOption.value == index
                      ? AppColors.primaryColor
                      : Get.theme.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Text buildTitle({required String title}) {
  return Text(
    title,
    style: GoogleFonts.figtree(fontSize: 18, fontWeight: FontWeight.w600),
  );
}

Wrap buildListOptions({
  required List<String> options,
  required RxList selectedOptions,
}) {
  return Wrap(
    runSpacing: 10,
    children: List.generate(
      options.length,
      (index) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Obx(() {
          return InkWell(
            onTap: () {
              if (selectedOptions.contains(options[index])) {
                selectedOptions.removeAt(
                  selectedOptions.indexOf(options[index]),
                );
              } else {
                selectedOptions.add(options[index]);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: selectedOptions.contains(options[index])
                    ? Border.all(color: AppColors.primaryColor)
                    : Border.all(color: Colors.grey),
                color: Colors.transparent,
              ),
              child: Text(
                options[index],
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: selectedOptions.contains(options[index])
                      ? AppColors.primaryColor
                      : Get.theme.primaryColor,
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );
}

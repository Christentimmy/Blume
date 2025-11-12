import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FunctionalDatePicker extends StatefulWidget {
  final Function(String)? onDateChanged;

  const FunctionalDatePicker({super.key, this.onDateChanged});

  @override
  State createState() => _FunctionalDatePickerState();
}

class _FunctionalDatePickerState extends State<FunctionalDatePicker> {
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  // Generate lists for dropdowns
  List<int> get days => List.generate(31, (index) => index + 1);
  List<int> get months => List.generate(12, (index) => index + 1);
  List<int> get years {
    final currentYear = DateTime.now().year;
    return List.generate(100, (index) => currentYear - index);
  }

  // Get days in selected month/year
  int getDaysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  void _updateDate() {
    try {
      if (selectedDay != null &&
          selectedMonth != null &&
          selectedYear != null) {
        final maxDays = getDaysInMonth(selectedMonth!, selectedYear!);
        if (selectedDay! > maxDays) {
          setState(() {
            selectedDay = maxDays;
          });
        }
        final date = DateTime(selectedYear!, selectedMonth!, selectedDay!);
        final formattedDate = date.toIso8601String();
        widget.onDateChanged?.call(formattedDate);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget _buildDropdownContainer({
    required String placeholder,
    required int? value,
    required List<int> items,
    required Function(int?) onChanged,
    String Function(int)? displayText,
  }) {
    return Container(
      height: Get.height * 0.07,
      width: Get.width * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          hint: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                placeholder,
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Get.theme.primaryColor,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
          icon: const SizedBox.shrink(),
          isExpanded: true,
          menuMaxHeight: Get.height * 0.6,
          items: items.map((int item) {
            return DropdownMenuItem<int>(
              value: item,
              child: Center(
                child: Text(
                  displayText?.call(item) ?? item.toString().padLeft(2, '0'),
                  style: GoogleFonts.figtree(
                    fontSize: 16,
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (int? newValue) {
            onChanged(newValue);
            _updateDate();
          },
          dropdownColor: Get.isDarkMode
              ? const Color.fromARGB(255, 100, 19, 13)
              : Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter days based on selected month/year
    List<int> availableDays = days;
    if (selectedMonth != null && selectedYear != null) {
      final maxDays = getDaysInMonth(selectedMonth!, selectedYear!);
      availableDays = List.generate(maxDays, (index) => index + 1);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDropdownContainer(
          placeholder: "DD",
          value: selectedDay,
          items: availableDays,
          onChanged: (value) {
            setState(() {
              selectedDay = value;
            });
          },
        ),
        _buildDropdownContainer(
          placeholder: "MM",
          value: selectedMonth,
          items: months,
          onChanged: (value) {
            setState(() {
              selectedMonth = value;
            });
          },
          displayText: (month) {
            const monthNames = [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec',
            ];
            return monthNames[month - 1];
          },
        ),
        _buildDropdownContainer(
          placeholder: "YYYY",
          value: selectedYear,
          items: years.reversed.toList(), // Most recent years first
          onChanged: (value) {
            setState(() {
              selectedYear = value;
            });
          },
          displayText: (year) => year.toString(),
        ),
      ],
    );
  }
}

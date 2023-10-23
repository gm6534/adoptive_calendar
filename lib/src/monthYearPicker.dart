import 'package:flutter/cupertino.dart';

class DatePicker extends StatelessWidget {
  final Function(DateTime) onMonthYearChanged;
  final DateTime initialDateTime;
  final int? minYear;
  final int? maxYear;

  const DatePicker({
    Key? key,
    required this.onMonthYearChanged,
    required this.initialDateTime,
    this.minYear,
    this.maxYear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
        mode: CupertinoDatePickerMode.monthYear,
        minimumYear: minYear ?? DateTime.now().year,
        maximumYear: maxYear ?? 2100,
        initialDateTime: initialDateTime,
        onDateTimeChanged: onMonthYearChanged);
  }
}

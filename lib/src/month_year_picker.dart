import 'package:flutter/cupertino.dart';

/// A widget for picking a month and year using a Cupertino-style date picker.
class DatePicker extends StatelessWidget {
  /// A callback function that is called when the selected month and year change.
  final Function(DateTime) onMonthYearChanged;

  /// The initial date to be displayed in the date picker.
  final DateTime initialDateTime;

  /// The minimum year that can be selected in the date picker. Defaults to the current year.
  final int? minYear;

  /// The maximum year that can be selected in the date picker. Defaults to the year 2100.
  final int? maxYear;

  /// Creates an instance of [DatePicker].
  ///
  /// The [onMonthYearChanged] callback is required and is called when the user
  /// selects a new month and year. The [initialDateTime] represents the initial
  /// date displayed in the picker. You can customize the selectable range by
  /// specifying the [minYear] and [maxYear].
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
      onDateTimeChanged: onMonthYearChanged,
    );
  }
}

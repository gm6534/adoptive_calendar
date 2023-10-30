import 'package:flutter/cupertino.dart';

class TimePicker extends StatelessWidget {
  final Function(DateTime) onDateTimeChanged;
  final DateTime initialDateTime;
  final int? minuteInterval;

  const TimePicker({
    Key? key,
    required this.onDateTimeChanged,
    required this.initialDateTime,
    this.minuteInterval,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: initialDateTime,
        minuteInterval: minuteInterval != null
            ? (minuteInterval! - initialDateTime.minute % minuteInterval!)
            : 1,
        onDateTimeChanged: onDateTimeChanged);
  }
}

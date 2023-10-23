import 'package:flutter/cupertino.dart';

class TimePicker extends StatelessWidget {
  final Function(DateTime) onDateTimeChanged;
  final DateTime initialDateTime;

  const TimePicker({
    Key? key,
    required this.onDateTimeChanged,
    required this.initialDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: initialDateTime,
        onDateTimeChanged: onDateTimeChanged);
  }
}

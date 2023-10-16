import 'package:adoptive_calendar/src/spacer.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'colors.dart';

class DurationPicker extends StatelessWidget {
  final int? hours;
  final int? minutes;
  final ValueChanged<int>? onChangedHours;
  final ValueChanged<int>? onChangedMinutes;
  final bool? isBorder;
  final bool? use24H;
  final bool isInfiniteLoop;
  final bool isCalenderUse;
  final Color? barColor;
  final Color? fontColor;

  const DurationPicker({
    Key? key,
    @required this.onChangedHours,
    @required this.onChangedMinutes,
    @required this.hours,
    @required this.minutes,
    this.isBorder = true,
    this.isInfiniteLoop = false,
    this.isCalenderUse = false,
    this.barColor,
    this.fontColor,
    this.use24H = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    bool isPortrait = (orientation == Orientation.portrait) ? true : false;
    return Container(
      // height: MediaQuery.of(context).copyWith().size.height * 0.25,
      decoration: BoxDecoration(
          // color: Colors.white,
          border: isBorder! ? Border.all(color: greyColor) : null,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: isPortrait ? (ht * 0.06) : (ht * 0.06),
              width: isPortrait ? (wid * 0.8) : (wid * 0.6),
              decoration: BoxDecoration(
                  color: barColor ?? Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: NumberPicker(
                    axis: Axis.vertical,
                    infiniteLoop: isInfiniteLoop,
                    minValue: isCalenderUse ? 1 : 00,
                    maxValue: 12,
                    step: 1,
                    // itemHeight: 50,
                    itemWidth: 30,
                    selectedTextStyle: TextStyle(
                        fontSize: 22.0,
                        color: fontColor ?? Colors.black,
                        fontWeight: FontWeight.w700),
                    value: hours!,
                    onChanged: onChangedHours!,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // border: Border.all(color: Colors.black26),
                    ),
                  ),
                ),
                // hSpace(5),
                Expanded(
                    child: Text(
                  "hours",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: fontColor),
                )),
                hSpace(10),
                Expanded(
                  child: NumberPicker(
                      axis: Axis.vertical,
                      infiniteLoop: isInfiniteLoop,
                      minValue: 00,
                      maxValue: 59,
                      step: 1,
                      // itemHeight: 50,
                      itemWidth: 40,
                      selectedTextStyle: TextStyle(
                          fontSize: 22.0,
                          color: fontColor ?? Colors.black,
                          fontWeight: FontWeight.w700),
                      value: isCalenderUse
                          ? minutes!
                          : (hours! == 12 ? 0 : minutes!),
                      onChanged: onChangedMinutes!,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        // border: Border.all(color: Colors.black26),
                      )),
                ),
                hSpace(5),
                Expanded(
                    child: Text(
                  "minutes",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: fontColor),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

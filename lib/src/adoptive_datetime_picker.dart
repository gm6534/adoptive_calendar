import 'package:adoptive_calendar/src/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'month_year_picker.dart';

class AdoptiveCalendar extends StatefulWidget {
  /// The initial date for the calendar.
  final DateTime initialDate;

  /// The background color of the calendar.
  final Color? backgroundColor;

  /// The font color for text in the calendar.
  final Color? fontColor;

  /// The color for selected dates in the calendar.
  final Color? selectedColor;

  /// The color for the heading (e.g., month and year) in the calendar.
  final Color? headingColor;

  /// The color for the bar at the top of the calendar.
  final Color? barColor;

  /// The foreground color for the bar at the top of the calendar.
  final Color? barForegroundColor;

  /// The color for icons in the calendar.
  final Color? iconColor;

  /// The minimum year available in the calendar.
  final int? minYear;

  /// The maximum year available in the calendar.
  final int? maxYear;

  /// The minute interval for time selection.
  final int minuteInterval;

  /// Whether to use 24-hour time format.
  final bool use24hFormat;

  /// Whether to use action for Ok.
  final bool action;

  /// Brand Icon will show your app identity and enhance user interest
  final Widget? brandIcon;

  /// Background effects will make attractive
  final AdoptiveBackground backgroundEffects;

  /// Creates an instance of [AdoptiveCalendar].
  ///
  /// The [initialDate] is required and represents the date to be initially
  /// displayed on the calendar. Other parameters are optional and can be
  /// customized to control the appearance and behavior of the calendar.

  const AdoptiveCalendar({
    super.key,
    required this.initialDate,
    this.backgroundColor,
    this.minYear,
    this.maxYear,
    this.fontColor,
    this.selectedColor,
    this.headingColor,
    this.iconColor,
    this.barColor,
    this.barForegroundColor,
    this.minuteInterval = 1,
    this.use24hFormat = false,
    this.brandIcon,
    this.backgroundEffects = AdoptiveBackground.none,
    this.action = false,
  });

  @override
  State<AdoptiveCalendar> createState() => _AdoptiveCalendarState();
}

class _AdoptiveCalendarState extends State<AdoptiveCalendar> {
  DateTime? _selectedDate;
  DateTime? returnDate;
  bool? isYearSelected;
  bool? isTimeSelected;
  bool? isAM;
  List<String> monthNames = Constants.repeatMonthNames;

  @override
  void initState() {
    /// Initialize the [_selectedDate] with the [initialDate] provided in the widget.
    _selectedDate = widget.initialDate;

    /// Set [isYearSelected] to false to indicate that a year has not been selected yet.
    isYearSelected = false;

    /// Set [isTimeSelected] to false to indicate that a time has not been selected yet.
    isTimeSelected = false;

    /// Determine whether it is AM or PM based on the initial hour of the [_selectedDate].
    isAM = _selectedDate!.hour < 12;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var orientation = MediaQuery.of(context).orientation;

    /// A boolean value that indicates whether the device is in portrait orientation.
    bool isPortrait = (orientation == Orientation.portrait) ? true : false;

    if (isPortrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    Widget calendarBody = isYearSelected!
        ? SizedBox(
            height: screenHeight * (isPortrait ? 0.29 : 0.55),
            child: DatePicker(
              minYear: widget.minYear,
              maxYear: widget.maxYear,
              initialDateTime: _selectedDate!,
              fontColor: widget.fontColor,
              onMonthYearChanged: (value) {
                int days = _selectedDate!.day;
                if (_selectedDate!.month == DateTime.january &&
                    _selectedDate!.day > 28) {
                  days = getDaysInMonth(value.year, value.month);
                }
                _selectedDate = DateTime(value.year, value.month, days,
                    _selectedDate!.hour, _selectedDate!.minute);
                returnDate = _selectedDate;
                setState(() {});
              },
            ),
          )
        : isTimeSelected!
            ? SizedBox(
                height: screenHeight * (isPortrait ? 0.29 : 0.55),
                child: TimePicker(
                  initialDateTime: _selectedDate!,
                  minuteInterval: widget.minuteInterval,
                  use24hForm: widget.use24hFormat,
                  fontColor: widget.fontColor,
                  onDateTimeChanged: (value) {
                    _selectedDate = DateTime(
                        _selectedDate!.year,
                        _selectedDate!.month,
                        _selectedDate!.day,
                        value.hour,
                        value.minute);
                    isAM = _selectedDate!.hour < 12;
                    returnDate = _selectedDate;
                    setState(() {});
                  },
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 7, // 7 days a week, 6 weeks maximum
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Text(
                            Constants.weekDayName[index].toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: widget.headingColor ??
                                    Colors.grey.shade400),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 7 * 6, // 7 days a week, 6 weeks maximum
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        crossAxisCount: 7,
                      ),
                      itemBuilder: (context, index) {
                        final day = index -
                            DateTime(_selectedDate!.year, _selectedDate!.month,
                                    1)
                                .weekday +
                            2;

                        return GestureDetector(
                          onTap: () {
                            if (day > 0 &&
                                day <=
                                    DateTime(_selectedDate!.year,
                                            _selectedDate!.month + 1, 0)
                                        .day) {
                              setState(() {
                                _selectedDate = DateTime(
                                    _selectedDate!.year,
                                    _selectedDate!.month,
                                    day,
                                    _selectedDate!.hour,
                                    _selectedDate!.minute);
                                returnDate = _selectedDate;
                              });
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: day <= 0 ||
                                        day >
                                            DateTime(_selectedDate!.year,
                                                    _selectedDate!.month + 1, 0)
                                                .day
                                    ? Colors.transparent
                                    : _isSelectedDay(day)
                                        ? (widget.selectedColor ?? Colors.blue)
                                            .withOpacity(0.1)
                                        : Colors.transparent,
                                shape: BoxShape.circle),
                            child: Text(
                              day <= 0 ||
                                      day >
                                          DateTime(_selectedDate!.year,
                                                  _selectedDate!.month + 1, 0)
                                              .day
                                  ? ''
                                  : '$day',
                              style: TextStyle(
                                fontWeight: _isSelectedDay(day)
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: (_isSelectedDay(day) ||
                                        day == DateTime.now().day)
                                    ? (widget.selectedColor ?? Colors.blue)
                                    : widget.fontColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );

    List<Widget> topArrowBody = [
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              isTimeSelected = false;
              isYearSelected = !isYearSelected!;
              setState(() {});
            },
            child: Text(
              "${monthNames[_selectedDate!.month - 1]} ${_selectedDate!.year}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: widget.headingColor),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            isYearSelected!
                ? Icons.keyboard_arrow_down_rounded
                : Icons.arrow_forward_ios_rounded,
            color: widget.iconColor ?? Colors.blue,
            size: isYearSelected! ? 30 : 15,
          ),
          Expanded(child: Container()),
          if (!isYearSelected!) ...[
            IconButton(
              onPressed: () {
                int year = _selectedDate!.year;
                int month = _selectedDate!.month;
                if (_selectedDate!.month == DateTime.january) {
                  year--;
                  month = 12;
                } else {
                  month = _selectedDate!.month - 1;
                }
                int decrement = getDaysInMonth(year, month);
                setState(() {
                  _selectedDate =
                      _selectedDate?.subtract(Duration(days: decrement));
                  returnDate = _selectedDate;
                });
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: widget.iconColor ?? Colors.blue,
                size: 15,
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                int year = _selectedDate!.year;
                int month = _selectedDate!.month;
                if (_selectedDate!.month == DateTime.december) {
                  year++;
                  month = 1;
                } else {
                  month = _selectedDate!.month + 1;
                }
                int increment = getDaysInMonth(year, month);
                setState(() {
                  _selectedDate = _selectedDate?.add(Duration(days: increment));
                  returnDate = _selectedDate;
                });
              },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: widget.iconColor ?? Colors.blue,
                size: 15,
              ),
            ),
          ]
        ],
      ),
      if (isPortrait)
        const SizedBox(
          height: 10,
        ),
    ];

    Widget amPMWidget = Container(
      height: 40,
      width: screenWidth * (isPortrait ? 0.32 : 0.3),
      decoration: BoxDecoration(
          color: widget.barColor ?? Colors.grey.shade300,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: isTimeSelected!
                      ? null
                      : () {
                          isAM = !isAM!;
                          _selectedDate = DateTime(
                              _selectedDate!.year,
                              _selectedDate!.month,
                              _selectedDate!.day,
                              isAM!
                                  ? _selectedDate!.hour % 12 == 0
                                      ? 12
                                      : _selectedDate!.hour % 12
                                  : _selectedDate!.hour + 12,
                              _selectedDate!.minute);
                          returnDate = _selectedDate;
                          setState(() {});
                        },
                  child: Container(
                    // height: 40,
                    // width: screenWidth * 0.14,
                    decoration: BoxDecoration(
                        color: isAM!
                            ? widget.barForegroundColor ?? Colors.white
                            : null,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          "AM",
                          style: TextStyle(
                            color: widget.barForegroundColor != null
                                ? widget.fontColor
                                : null,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
              Expanded(
                child: GestureDetector(
                  onTap: isTimeSelected!
                      ? null
                      : () {
                          isAM = !isAM!;
                          _selectedDate = DateTime(
                              _selectedDate!.year,
                              _selectedDate!.month,
                              _selectedDate!.day,
                              isAM!
                                  ? _selectedDate!.hour % 12 == 0
                                      ? 12
                                      : _selectedDate!.hour % 12
                                  : _selectedDate!.hour + 12,
                              _selectedDate!.minute);
                          returnDate = _selectedDate;
                          setState(() {});
                        },
                  child: Container(
                    // height: 40,
                    // width: screenWidth * 0.14,
                    decoration: BoxDecoration(
                        color: !isAM!
                            ? widget.barForegroundColor ?? Colors.white
                            : null,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          "PM",
                          style: TextStyle(
                            color: widget.barForegroundColor != null
                                ? widget.fontColor
                                : null,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Widget timeWidget = GestureDetector(
      onTap: () {
        isTimeSelected = !isTimeSelected!;
        isYearSelected = false;
        setState(() {});
      },
      child: Container(
        height: 40,
        width: screenWidth * (isPortrait ? 0.25 : 0.3),
        decoration: BoxDecoration(
            color: (widget.barColor ?? Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            // child: Text("${_selectedDate.hour}:${_selectedDate.minute}",
            child: FittedBox(
              child: Text(
                _selectedDate!
                    .format12Hour(use24HoursFormat: widget.use24hFormat),
                style: TextStyle(
                    color: widget.barColor != null ? widget.fontColor : null,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 3),
              ),
            ),
          ),
        ),
      ),
    );

    List<Widget> pickTimeBody = [
      /// Brand Logo Widget
      if (!widget.action || widget.use24hFormat) ...[
        if (widget.brandIcon != null)
          Center(
            child: SizedBox(
                height: isPortrait ? 35 : 45, child: widget.brandIcon!),
          )
        else
          Text(
            "Time",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: widget.headingColor),
          ),
        if (isPortrait) Expanded(child: Container()),
        if (!isPortrait) Container(height: screenHeight * 0.1),
      ],

      /// Time Widget
      timeWidget,

      // if (!widget.use24hFormat!)
      /// AM-PM Widget
      ...[
        if (isPortrait) SizedBox(width: screenWidth * 0.02),
        if (!isPortrait) Container(height: screenHeight * 0.1),
        if (!widget.use24hFormat) amPMWidget
      ],

      /// Action Widget
      if (widget.action) ...[
        if (isPortrait) Expanded(child: Container()),
        if (!isPortrait) Container(height: screenHeight * 0.1),
        GestureDetector(
            onTap: () {
              Navigator.pop(context, returnDate);
            },
            child: Text(
              "Save",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.fontColor,
                  fontSize: 15),
            ))
      ],
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);

        /// Close the current screen and return the [returnDate] to the previous screen.
        Navigator.pop(context, widget.action ? null : returnDate);
      },
      child: Dialog(
        backgroundColor: widget.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        insetPadding: EdgeInsets.symmetric(horizontal: isPortrait ? 20 : 60),
        child: Container(
          decoration: widget.backgroundEffects.imageUrl.isNotEmpty
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.backgroundEffects.imageUrl)),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15.0,
            ),
            child: isPortrait
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Upper Section
                        ...topArrowBody,
                        calendarBody,
                        // Lower Section
                        const Divider(
                          thickness: 0.5,
                        ),
                        Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: pickTimeBody),
                      ],
                    ),
                  )
                : SizedBox(
                    width: screenWidth * 0.7,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...topArrowBody,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  // height: screenHeight * 0.57,
                                  // width: screenWidth / 3,
                                  child: calendarBody),
                              // const Spacer(),
                              Expanded(
                                  // height: screenHeight * 0.57,
                                  // width: screenWidth / 3,
                                  child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: pickTimeBody,
                                ),
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  bool _isSelectedDay(int day) {
    /// Check if the provided [day] matches the day of the [_selectedDate].
    return _selectedDate!.day == day;
  }

  int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }
}

/// Here is the constant enum
enum AdoptiveBackground {
  christmas,
  winter,
  snowFall,
  summer,
  halloween,
  smokyLeaves,
  none
}

extension DateTimeExtension on DateTime {
  String format12Hour({required bool use24HoursFormat}) {
    /// Convert hour to 12-hour format
    // int hour12 = (hour % 12 == 0 ? 12 : hour % 12);
    int hour12 = use24HoursFormat ? hour : (hour % 12 == 0 ? 12 : hour % 12);

    /// Add leading zero for single-digit hours
    String hourString = hour12 < 10 ? '0$hour12' : '$hour12';

    /// Add leading zero for single-digit minutes
    String minuteString = minute < 10 ? '0$minute' : '$minute';

    /// Return formatted time
    return '$hourString:$minuteString';
  }
}

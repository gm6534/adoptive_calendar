import 'package:adoptive_calendar/adoptive_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Example Adoptive Calendar',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleAdoptiveCalendar(),
    );
  }
}

class ExampleAdoptiveCalendar extends StatefulWidget {
  const ExampleAdoptiveCalendar({super.key});

  @override
  State<ExampleAdoptiveCalendar> createState() =>
      _ExampleAdoptiveCalendarState();
}

class _ExampleAdoptiveCalendarState extends State<ExampleAdoptiveCalendar> {
  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Adoptive Calendar Example",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Center(
                child: ElevatedButton(
              onPressed: () async {
                pickedDate = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdoptiveCalendar(
                      initialDate: DateTime.now(),
                      brandIcon: Image.asset(
                        'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png',
                        color: Colors.blue,
                      ),
                      // datePickerOnly: true,
                      // action: true,
                      // backgroundEffects: AdoptiveBackground.christmas,
                      // use24hFormat: true,
                      // minuteInterval: 1,
                      // backgroundColor: Colors.blue,
                      // fontColor: Colors.white,
                      // selectedColor: Colors.yellow,
                      // headingColor: Colors.white,
                      // iconColor: Colors.white,
                      // barColor: Colors.purpleAccent,
                      // barForegroundColor: Colors.tealAccent,
                    );
                  },
                );
                setState(() {});
              },
              child: const Text("Open Default Calendar"),
            )),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Center(
                child: ElevatedButton(
              onPressed: () async {
                pickedDate = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdoptiveCalendar(
                      initialDate: DateTime.now(),
                      brandIcon: Image.asset(
                        'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png',
                        color: Colors.blue,
                      ),
                      action: true,
                    );
                  },
                );
                setState(() {});
              },
              child: const Text("Open Default Calendar with action"),
            )),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Center(
                child: ElevatedButton(
              onPressed: () async {
                pickedDate = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdoptiveCalendar(
                      initialDate: DateTime.now(),
                      use24hFormat: true,
                    );
                  },
                );
                setState(() {});
              },
              child: const Text("Open 24 Hours Format Calendar"),
            )),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Center(
                child: ElevatedButton(
              onPressed: () async {
                pickedDate = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdoptiveCalendar(
                      initialDate: DateTime.now(),
                      datePickerOnly: true,
                      // action: true,
                      // backgroundEffects: AdoptiveBackground.christmas,
                      // use24hFormat: true,
                      // minuteInterval: 1,
                      // backgroundColor: Colors.blue,
                      // fontColor: Colors.white,
                      // selectedColor: Colors.yellow,
                      // headingColor: Colors.white,
                      // iconColor: Colors.white,
                      // barColor: Colors.purpleAccent,
                      // barForegroundColor: Colors.tealAccent,
                    );
                  },
                );
                setState(() {});
              },
              child: const Text("Open Date Picker Only"),
            )),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Center(
                child: ElevatedButton(
              onPressed: () async {
                pickedDate = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdoptiveCalendar(
                      initialDate: DateTime.now(),
                      datePickerOnly: true,
                      action: true,
                      // backgroundEffects: AdoptiveBackground.christmas,
                      // use24hFormat: true,
                      // minuteInterval: 1,
                      // backgroundColor: Colors.blue,
                      // fontColor: Colors.white,
                      // selectedColor: Colors.yellow,
                      // headingColor: Colors.white,
                      // iconColor: Colors.white,
                      // barColor: Colors.purpleAccent,
                      // barForegroundColor: Colors.tealAccent,
                    );
                  },
                );
                setState(() {});
              },
              child: const Text("Open Date Picker with action"),
            )),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Center(
                child: ElevatedButton(
              onPressed: () async {
                pickedDate = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdoptiveCalendar(
                      initialDate: DateTime.now(),
                      backgroundEffects: AdoptiveBackground.summer,
                      // use24hFormat: true,
                      fontColor: Colors.white,
                      selectedColor: Colors.yellowAccent,
                      headingColor: Colors.white,
                      iconColor: Colors.white,
                      barForegroundColor: Colors.lightGreen,
                    );
                  },
                );
                setState(() {});
              },
              child: const Text("Open Calendar with Theme"),
            )),
          ),
          const Spacer(),
          Center(
              child: Text((pickedDate ?? "Selected Date Result Once You Picked")
                  .toString())),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

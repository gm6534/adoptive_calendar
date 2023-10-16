import 'package:adoptive_calendar/adoptive_calendar.dart';
import 'package:flutter/cupertino.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
                child: ElevatedButton(
              onPressed: () async {
                pickedDate = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdoptiveCalendar(
                      initialDate: DateTime.now(),
                      // use24hFormat: true,
                      // backgroundColor: Colors.green,
                      // fontColor: Colors.white,
                      // selectedColor: Colors.yellow,
                      // headingColor: Colors.deepPurple,
                      // iconColor: Colors.yellow,
                      // barColor: Colors.purpleAccent,
                      // barForegroundColor: Colors.tealAccent,
                    );
                  },
                );
                setState(() {});
              },
              child: const Text("Open Calendar"),
            )),
          ),
          const SizedBox(height: 20),
          Text(pickedDate.toString()),
        ],
      ),
    );
  }
}

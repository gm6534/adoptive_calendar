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
                      // use24hFormat: true,
                      // minuteInterval: 1,
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
          Center(child: Text(pickedDate.toString())),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

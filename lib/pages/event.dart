import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {

  final String _eventText = "This page will hold event info.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("Event"),
        backgroundColor: Colors.teal[800],
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                _eventText,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
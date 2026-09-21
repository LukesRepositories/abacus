import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {

  final String _mapText = "This is the map page.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("Map"),
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
                _mapText,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/event');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Event",
                    style: TextStyle(fontSize: 20),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
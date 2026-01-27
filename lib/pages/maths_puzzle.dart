import 'package:flutter/material.dart';

class MathsPuzzle extends StatefulWidget {
  const MathsPuzzle({super.key});

  @override
  State<MathsPuzzle> createState() => _MathsPuzzleState();
}

class _MathsPuzzleState extends State<MathsPuzzle> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("Maths Puzzle"),
        backgroundColor: Colors.teal[800],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
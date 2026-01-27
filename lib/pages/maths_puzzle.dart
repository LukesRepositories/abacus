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
      appBar: AppBar(title: const Text("Maths Puzzle")),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
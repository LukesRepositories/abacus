import 'package:flutter/material.dart';

class MathsPuzzle extends StatefulWidget {
  const MathsPuzzle({super.key});

  @override
  State<MathsPuzzle> createState() => _MathsPuzzleState();
}

class _MathsPuzzleState extends State<MathsPuzzle> {

  Color _boxColour = Colors.white;
  int _numberA1 = 0;
  String _numberStringA1 = "";

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
          children: List.generate(5, (rowIndex) {
            return Row(
              children: List.generate(5, (colIndex) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(4),
                    color: _boxColour, // Changes based on game state
                  ),
                  child: Center(
                    child: Text(
                      _numberStringA1,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      )
    );
  }
}
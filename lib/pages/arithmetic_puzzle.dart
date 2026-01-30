import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:abacus/services/arithmetic_puzzle.dart';
import 'package:abacus/model/arithmetic_puzzle/maths_puzzle.dart';

class ArithmeticPuzzle extends StatefulWidget {
  const ArithmeticPuzzle({super.key});

  @override
  State<ArithmeticPuzzle> createState() => _ArithmeticPuzzleState();
}

class _ArithmeticPuzzleState extends State<ArithmeticPuzzle> {

  Color _boxColour = Colors.white;
  int _numberA1 = 0;
  String _numberStringA1 = "";

  ArithmeticPuzzleService puzzleService = ArithmeticPuzzleService();

  late MathsPuzzleObject puzzleObject = puzzleService.generatePuzzle();

  String getBoxContent(int col, int row) {
    String boxContent = col.toString() + " " + row.toString();

    return boxContent;
  }

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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (rowIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: _boxColour, // Changes based on game state
                      ),
                      child: Center(
                        child: Text(
                          puzzleObject.firstNumber.toString(),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: _boxColour, // Changes based on game state
                      ),
                      child: Center(
                        child: Text(
                          puzzleObject.operator,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: _boxColour, // Changes based on game state
                      ),
                      child: Center(
                        child: Text(
                          puzzleObject.secondNumber.toString(),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: _boxColour, // Changes based on game state
                      ),
                      child: Center(
                        child: Text(
                          "=",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: _boxColour, // Changes based on game state
                      ),
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,  // Only allows digits 0-9
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter sandman",
              ),
            )
          ],
        ),
      )
    );
  }
}
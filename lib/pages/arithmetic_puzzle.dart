import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:abacus/services/puzzle_generator.dart';
import 'package:abacus/model/arithmetic_puzzle/maths_puzzle.dart';

class ArithmeticPuzzle extends StatefulWidget {
  const ArithmeticPuzzle({super.key});

  @override
  State<ArithmeticPuzzle> createState() => _ArithmeticPuzzleState();
}

class _ArithmeticPuzzleState extends State<ArithmeticPuzzle> {

  late List<Color> rowColours;
  late List<bool> isLockedList;
  late List<MathsPuzzleObject> questions;
  late List<FocusNode> focusNodes;
  late List<Duration> times;
  Stopwatch stopwatch = Stopwatch();
  int previousRow = 0;

  PuzzleGenerator puzzleService = PuzzleGenerator();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rowColours = List.generate(5, (i) => Colors.white);
    questions = List.generate(5, (i) => puzzleService.generatePuzzle(i));
    isLockedList = List.generate(5, (i) => false);
    focusNodes = List.generate(5, (i) => FocusNode());
    times = List.generate(5, (i) => Duration.zero);
    stopwatch = stopwatch..start();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for(var node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],

      appBar: AppBar(
        title: const Text("Arithmetic Teaser"),
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
                        color: rowColours[rowIndex], // Changes based on game state
                      ),
                      child: Center(
                        child: Text(
                          questions[rowIndex].firstNumber.toString(),
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
                        color: rowColours[rowIndex], // Changes based on game state
                      ),
                      child: Center(
                        child: Text(
                          questions[rowIndex].operator,
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
                        color: rowColours[rowIndex], // Changes based on game state
                      ),
                      child: Center(
                        child: Text(
                          questions[rowIndex].secondNumber.toString(),
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
                        color: rowColours[rowIndex], // Changes based on game state
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
                        color: rowColours[rowIndex], // Changes based on game state
                      ),
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          readOnly: isLockedList[rowIndex],
                          focusNode: focusNodes[rowIndex],
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
                          onSubmitted: (value){
                            if(value.isNotEmpty) {
                              setState(() {
                                times[rowIndex] = stopwatch.elapsed - times[previousRow];
                                isLockedList[rowIndex] = true;
                                previousRow = rowIndex;
                                if(rowIndex < 4) focusNodes[rowIndex+1].requestFocus();
                                if(int.parse(value ?? '0') == questions[rowIndex].answer){
                                  rowColours[rowIndex] = Colors.green;
                                } else {
                                  rowColours[rowIndex] = Colors.red;
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (rowIndex) {
                return Row(
                  children: [
                    if(times[rowIndex] != Duration.zero) Text(
                      "${times[rowIndex]}",
                    ),
                  ],
                );
              }),
            )
          ],
        ),
      )
    );
  }
}
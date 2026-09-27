import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:abacus/services/puzzle_generator.dart';
import 'package:abacus/model/arithmetic_puzzle/maths_puzzle.dart';
import 'package:abacus/model/arithmetic_puzzle/puzzle_session.dart';
import 'package:abacus/services/database_service.dart';

class ArithmeticPuzzle extends StatefulWidget {
  const ArithmeticPuzzle({super.key});

  @override
  State<ArithmeticPuzzle> createState() => _ArithmeticPuzzleState();
}

class _ArithmeticPuzzleState extends State<ArithmeticPuzzle> {

  late List<Color> rowColours;
  late List<bool> isLockedList;
  late List<MathsPuzzleObject> questions;
  int numQuestions = 5;
  late List<FocusNode> focusNodes;
  Stopwatch stopwatch = Stopwatch();
  int previousRow = 0;

  String? difficulty; // = await DatabaseService.dataServiceInstance.getDifficulty();

  PuzzleGenerator puzzleService = PuzzleGenerator();

  Future<void> _loadDifficulty() async {
    final fromDB = await DatabaseService.dataServiceInstance.getDifficulty();
    difficulty = fromDB;
  }

  void _resetPuzzleSession() {
    _loadDifficulty();
    rowColours = List.generate(numQuestions, (i) => Colors.white);
    questions = List.generate(numQuestions, (i) => puzzleService.generatePuzzle(i, difficulty.toString()));
    isLockedList = List.generate(numQuestions, (i) => false);
    focusNodes = List.generate(numQuestions, (i) => FocusNode());
    stopwatch = Stopwatch()..start();
    previousRow = 0;
  }

  Future<void> _logSession() async {
    final int score = rowColours.where((colour) => colour == Colors.green).length;

    final PuzzleSession session = PuzzleSession(
      dateTime: DateTime.now(),
      score: score,
      total: numQuestions,
      mode: difficulty ?? 'Medium',
      totalTimeMs: stopwatch.elapsedMilliseconds,
    );

    await DatabaseService.dataServiceInstance.insertPuzzleSession(session);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _resetPuzzleSession();
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
                          questions[rowIndex].operator.toString(),
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
                                isLockedList[rowIndex] = true;
                                previousRow = rowIndex;
                                if(rowIndex < numQuestions-1) focusNodes[rowIndex+1].requestFocus();
                                if(int.parse(value ?? '0') == questions[rowIndex].answer){
                                  rowColours[rowIndex] = Colors.green;
                                } else {
                                  rowColours[rowIndex] = Colors.red;
                                }
                                if(rowIndex == numQuestions-1) {
                                  // Send to database to create new row
                                  stopwatch.stop();
                                  _logSession();
                                  // Possibly add pop up message
                                  _showAlertDialogue(context);
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

            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    _resetPuzzleSession();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Reset",
                    style: TextStyle(fontSize: 20),
                  ),
                )
            ),

          ],
        ),
      )
    );
  }
}

void _showAlertDialogue(context) {
  showDialog<String>(
    context:  context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Puzzle Session Saved'),
      content: const Text('You did it in Nms'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:abacus/services/puzzle_generator.dart';
import 'package:abacus/services/database_helper.dart';
import 'package:abacus/model/arithmetic_puzzle/maths_puzzle.dart';
import 'package:abacus/model/arithmetic_puzzle/puzzle_session.dart';

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
  Duration lastSplit = Duration.zero;
  bool _sessionSaved = false;

  PuzzleGenerator puzzleService = PuzzleGenerator();

  @override
  void initState() {
    super.initState();
    _resetPuzzle();
  }

  void _resetPuzzle() {
    rowColours = List.generate(5, (i) => Colors.white);
    questions = List.generate(5, (i) => puzzleService.generatePuzzle(i));
    isLockedList = List.generate(5, (i) => false);
    focusNodes = List.generate(5, (i) => FocusNode());
    times = List.generate(5, (i) => Duration.zero);
    lastSplit = Duration.zero;
    _sessionSaved = false;
    stopwatch = Stopwatch()..start();
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _saveSessionIfComplete() async {
    if (_sessionSaved) return;
    if (!isLockedList.every((locked) => locked)) return;

    _sessionSaved = true;
    stopwatch.stop();

    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (rowColours[i] == Colors.green) score++;
    }

    final totalTimeMs = times.fold<int>(0, (sum, t) => sum + t.inMilliseconds);

    final session = PuzzleSession(
      name: "Arithmetic session",
      dateTime: DateTime.now(),
      score: score,
      total: questions.length,
      totalTimeMs: totalTimeMs,
    );

    await DatabaseHelper.instance.insertSession(session);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Session saved — $score/${questions.length} correct"),
          backgroundColor: Colors.teal[800],
        ),
      );
    }
  }

  void _submitAnswer(int rowIndex, String value) {
    if (value.isEmpty) return;

    setState(() {
      final elapsed = stopwatch.elapsed;
      times[rowIndex] = elapsed - lastSplit;
      lastSplit = elapsed;

      isLockedList[rowIndex] = true;
      if (rowIndex < 4) focusNodes[rowIndex + 1].requestFocus();

      if (int.parse(value) == questions[rowIndex].answer) {
        rowColours[rowIndex] = Colors.green;
      } else {
        rowColours[rowIndex] = Colors.red;
      }
    });

    _saveSessionIfComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],

      appBar: AppBar(
        title: const Text("Arithmetic Teaser"),
        backgroundColor: Colors.teal[800],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            tooltip: "New puzzle",
            onPressed: () {
              setState(() {
                _resetPuzzle();
              });
            },
          ),
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
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
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: rowColours[rowIndex],
                        ),
                        child: Center(
                          child: Text(
                            questions[rowIndex].firstNumber.toString(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: rowColours[rowIndex],
                        ),
                        child: Center(
                          child: Text(
                            questions[rowIndex].operator,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: rowColours[rowIndex],
                        ),
                        child: Center(
                          child: Text(
                            questions[rowIndex].secondNumber.toString(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: rowColours[rowIndex],
                        ),
                        child: const Center(
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
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: rowColours[rowIndex],
                        ),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            readOnly: isLockedList[rowIndex],
                            focusNode: focusNodes[rowIndex],
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            onSubmitted: (value) => _submitAnswer(rowIndex, value),
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
                      if (times[rowIndex] != Duration.zero)
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "${(times[rowIndex].inMilliseconds / 1000).toStringAsFixed(1)}s",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

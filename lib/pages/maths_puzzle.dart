import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MathsPuzzle extends StatefulWidget {
  const MathsPuzzle({super.key});

  @override
  State<MathsPuzzle> createState() => _MathsPuzzleState();
}

class _MathsPuzzleState extends State<MathsPuzzle> {

  Color _boxColour = Colors.white;
  int _numberA1 = 0;
  String _numberStringA1 = "";

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
                  children: List.generate(5, (colIndex) {
                    if(colIndex == 1) {
                      return Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(4),
                          color: _boxColour, // Changes based on game state
                        ),
                        child: Center(
                          child: Text(
                            "+",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                    else if(colIndex == 3) {
                      return Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(4),
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
                      );
                    }
                    else if(colIndex == 4) {
                      return Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(4),
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
                      );
                    } else {
                      return Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(4),
                          color: _boxColour, // Changes based on game state
                        ),
                        child: Center(
                          child: Text(
                            getBoxContent(colIndex, rowIndex),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }

                  }),
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
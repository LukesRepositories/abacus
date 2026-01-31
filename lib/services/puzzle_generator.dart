import 'dart:math';

import 'package:abacus/model/arithmetic_puzzle/maths_puzzle.dart';

// Check what the safest string comparison is
// Add try catch statements
// Make sure numbers are divisible to a whole number

class PuzzleGenerator {

  MathsPuzzleObject generatePuzzle() {
    int tempFirst = Random().nextInt(99)+1;
    int tempSecond = Random().nextInt(9)+1;

    List<String> operators = ['x', '+', '-', '÷'];
    String tempOperator = operators[Random().nextInt(operators.length)];

    int tempAnswer = 0;

    if(tempOperator == 'x') {
      tempAnswer = tempFirst * tempSecond;
    } else if(tempOperator == '+') {
      tempAnswer = tempFirst + tempSecond;
    } else if(tempOperator == '-') {
      tempAnswer = tempFirst - tempSecond;
    } else if(tempOperator == '÷') {
      tempAnswer = tempFirst ~/ tempSecond;
    }

    MathsPuzzleObject puzzle = MathsPuzzleObject(tempFirst, tempOperator, tempSecond, tempAnswer);

    return puzzle;
  }

}
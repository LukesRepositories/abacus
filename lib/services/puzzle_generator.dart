import 'dart:math';

import 'package:abacus/model/arithmetic_puzzle/maths_puzzle.dart';

// Check what the safest string comparison is
// Add try catch statements
// Make sure numbers are divisible to a whole number

class PuzzleGenerator {

  MathsPuzzleObject generatePuzzle(int rowIndex) {
    // Initialise variables
    int tempFirst = 0;
    int tempSecond = 0;
    int tempAnswer = 0;
    String tempOperator = "";

    switch(rowIndex) {
      case 0:
        tempFirst = Random().nextInt(98)+1;
        tempOperator = "x";
        tempSecond = Random().nextInt(19)+1;
        tempAnswer = tempFirst * tempSecond;
        break;

      case 1:
        tempFirst = Random().nextInt(98)+1;
        tempOperator = "+";
        tempSecond = Random().nextInt(98)+1;
        tempAnswer = tempFirst + tempSecond;
        break;

      case 2:
        tempFirst = Random().nextInt(98)+1;
        tempOperator = "-";
        tempSecond = Random().nextInt(98)+1;
        if(tempFirst < tempSecond) {
          int temp = tempFirst;
          tempFirst = tempSecond;
          tempSecond = temp;
        }
        tempAnswer = tempFirst - tempSecond;
        break;

      case 3:
        tempFirst = Random().nextInt(98)+1;
        tempOperator = "÷";
        tempSecond = Random().nextInt(11)+1;
        if(tempFirst % tempSecond != 0) {
          for(int i = 0; i <= 6; i++){
            if((tempFirst+i) % tempSecond == 0){
              tempFirst = tempFirst + i;
              break;
            }
            if((tempFirst-i) % tempSecond == 0){
              tempFirst = tempFirst - i;
              break;
            }
          }
        }
        tempAnswer = tempFirst ~/ tempSecond;
        break;

      default:
        tempFirst = Random().nextInt(98)+1;
        tempOperator = "x";
        tempSecond = Random().nextInt(19)+1;
        tempAnswer = tempFirst * tempSecond;
        break;
    }

    MathsPuzzleObject puzzle = MathsPuzzleObject(tempFirst, tempOperator, tempSecond, tempAnswer);
    return puzzle;
  }

}
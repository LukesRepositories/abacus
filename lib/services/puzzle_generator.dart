import 'dart:math';

import 'package:abacus/model/arithmetic_puzzle/maths_puzzle.dart';

class PuzzleGenerator {

  final Random _random = Random();

  MathsPuzzleObject generatePuzzle(int rowIndex, String difficulty) {
    // Initialise variables
    int tempFirst = 0;
    int tempSecond = 0;
    int tempAnswer = 0;
    String tempOperator = "";

    Map<String, int> ranges = setRandRange(difficulty);

    switch(rowIndex) {
      case 0:
        tempFirst = _random.nextInt(ranges['mulFir']!)+1;
        tempOperator = "x";
        tempSecond = _random.nextInt(ranges['mulSec']!)+1;
        tempAnswer = tempFirst * tempSecond;
        break;

      case 1:
        tempFirst = _random.nextInt(ranges['addFir']!)+1;
        tempOperator = "+";
        tempSecond = _random.nextInt(ranges['addSec']!)+1;
        tempAnswer = tempFirst + tempSecond;
        break;

      case 2:
        tempFirst = _random.nextInt(ranges['subFir']!)+1;
        tempOperator = "-";
        tempSecond = _random.nextInt(ranges['subSec']!)+1;
        if(tempFirst < tempSecond) {
          int temp = tempFirst;
          tempFirst = tempSecond;
          tempSecond = temp;
        }
        tempAnswer = tempFirst - tempSecond;
        break;

      case 3:
        tempFirst = _random.nextInt(ranges['divFir']!)+1;
        tempOperator = "÷";
        tempSecond = _random.nextInt(ranges['divSec']!)+1;
        if(tempFirst % tempSecond != 0) {
          for(int i = 0; i <= (ranges['divSec']!~/2); i++){
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
        tempFirst = _random.nextInt(98)+1;
        tempOperator = "x";
        tempSecond = _random.nextInt(11)+1;
        tempAnswer = tempFirst * tempSecond;
        break;
    }

    MathsPuzzleObject puzzle = MathsPuzzleObject(tempFirst, tempOperator, tempSecond, tempAnswer);
    return puzzle;
  }

  static Map<String, int> setRandRange(String difficulty) {
    switch(difficulty) {
      case 'Easy':
        return {
          'mulFir': 10,
          'mulSec': 10,
          'addFir': 30,
          'addSec': 30,
          'subFir': 30,
          'subSec': 30,
          'divFir': 50,
          'divSec': 10
        };


      case 'Medium':
        return {
          'mulFir': 30,
          'mulSec': 19,
          'addFir': 98,
          'addSec': 98,
          'subFir': 98,
          'subSec': 98,
          'divFir': 98,
          'divSec': 11
        };


      case 'Hard':
        return {
          'mulFir': 90,
          'mulSec': 90,
          'addFir': 300,
          'addSec': 300,
          'subFir': 800,
          'subSec': 600,
          'divFir': 180,
          'divSec': 20
      };
    }
    return { // Else Return Medium
      'mulFir': 30,
      'mulSec': 19,
      'addFir': 98,
      'addSec': 98,
      'subFir': 98,
      'subSec': 98,
      'divFir': 98,
      'divSec': 11
    };
  }

}
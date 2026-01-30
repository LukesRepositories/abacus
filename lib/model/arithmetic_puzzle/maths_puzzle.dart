
class MathsPuzzleObject {
  bool isOrdOfOp = false;
  int firstNumber = 0;
  String operator = "";
  int secondNumber = 0;
  int answer = 0;
  String orderOfOpString = "";

  MathsPuzzleObject(int firstNumberArg, String operatorArg, int secondNumberArg, int answerArg) {
    firstNumber = firstNumberArg;
    operator = operatorArg;
    secondNumber = secondNumberArg;
    answer = answerArg;
  }


}
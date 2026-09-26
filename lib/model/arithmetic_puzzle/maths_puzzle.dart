
class MathsPuzzleObject {
  int? firstNumber;
  String? operator;
  int? secondNumber;
  int? answer;

  MathsPuzzleObject(
    this.firstNumber,
    this.operator,
    this.secondNumber,
    this.answer,
  );

  MathsPuzzleObject.namedParams({
    this.firstNumber,
    this.operator,
    this.secondNumber,
    this.answer,
  });

}
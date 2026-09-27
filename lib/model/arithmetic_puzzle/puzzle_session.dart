
class PuzzleSession {
  int? id; // null until inserted into SQLite, which then assigns the rowid
  DateTime dateTime; // for the data
  int score; // number of correct answers
  int total; // number of questions in the session (5)
  String mode; // easy, medium or hard mode
  int totalTimeMs; // total time taken across all questions

  PuzzleSession({
    this.id,
    required this.dateTime,
    required this.score,
    required this.total,
    required this.mode,
    required this.totalTimeMs,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'score': score,
      'total': total,
      'mode': mode,
      'totalTimeMs': totalTimeMs,
    };
  }

  factory PuzzleSession.fromMap(Map<String, dynamic> map) {
    return PuzzleSession(
      id: map['id'] as int?,
      dateTime: DateTime.parse(map['dateTime'] as String),
      score: map['score'] as int,
      total: map['total'] as int,
      mode: map['mode'] as String,
      totalTimeMs: map['totalTimeMs'] as int,
    );
  }
}
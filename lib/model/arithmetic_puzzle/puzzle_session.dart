class PuzzleSession {
  int? id; // null until inserted into SQLite, which then assigns the rowid
  String name; // editable label for the session, e.g. "Morning practice"
  DateTime dateTime;
  int score; // number of correct answers
  int total; // number of questions in the session (5)
  int totalTimeMs; // total time taken across all questions

  PuzzleSession({
    this.id,
    required this.name,
    required this.dateTime,
    required this.score,
    required this.total,
    required this.totalTimeMs,
  });

  double get averageTimeMs => total == 0 ? 0 : totalTimeMs / total;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dateTime': dateTime.toIso8601String(),
      'score': score,
      'total': total,
      'totalTimeMs': totalTimeMs,
    };
  }

  factory PuzzleSession.fromMap(Map<String, dynamic> map) {
    return PuzzleSession(
      id: map['id'] as int?,
      name: map['name'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
      score: map['score'] as int,
      total: map['total'] as int,
      totalTimeMs: map['totalTimeMs'] as int,
    );
  }
}

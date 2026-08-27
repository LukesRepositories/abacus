import 'package:flutter/material.dart';

import 'package:abacus/model/arithmetic_puzzle/puzzle_session.dart';
import 'package:abacus/services/database_helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  late Future<List<PuzzleSession>> _sessionsFuture;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  // Public so Root can call it directly when this tab becomes visible again
  // (IndexedStack keeps Profile alive, so initState only runs once overall).
  void refresh() {
    _refresh();
  }

  void _refresh() {
    setState(() {
      _sessionsFuture = DatabaseHelper.instance.getAllSessions();
    });
  }

  Future<void> _renameSession(PuzzleSession session) async {
    final controller = TextEditingController(text: session.name);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename session"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Session name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      session.name = newName;
      await DatabaseHelper.instance.updateSession(session);
      _refresh();
    }
  }

  Future<void> _deleteSession(PuzzleSession session) async {
    await DatabaseHelper.instance.deleteSession(session.id!);
    _refresh();
  }

  Future<void> _confirmClearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Clear all history?"),
        content: const Text("This will permanently delete every recorded session."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Clear all"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await DatabaseHelper.instance.deleteAllSessions();
      _refresh();
    }
  }

  Widget _buildStatsHeader(List<PuzzleSession> sessions) {
    if (sessions.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalSessions = sessions.length;
    final totalCorrect = sessions.fold<int>(0, (sum, s) => sum + s.score);
    final totalQuestions = sessions.fold<int>(0, (sum, s) => sum + s.total);
    final accuracy = totalQuestions == 0
        ? 0.0
        : (totalCorrect / totalQuestions) * 100;

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.teal[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statColumn("Sessions", "$totalSessions"),
          _statColumn("Accuracy", "${accuracy.toStringAsFixed(0)}%"),
          _statColumn("Correct", "$totalCorrect/$totalQuestions"),
        ],
      ),
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.teal[100], fontSize: 13),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.teal[800],
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            tooltip: "Clear all history",
            onPressed: _confirmClearAll,
          ),
        ],
      ),
      body: FutureBuilder<List<PuzzleSession>>(
        future: _sessionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          final sessions = snapshot.data ?? [];

          if (sessions.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "No sessions yet. Complete a puzzle to see your results here.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          }

          return Column(
            children: [
              _buildStatsHeader(sessions),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    return Dismissible(
                      key: ValueKey(session.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => _deleteSession(session),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(
                            session.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${session.dateTime.day}/${session.dateTime.month}/${session.dateTime.year} "
                            "${session.dateTime.hour.toString().padLeft(2, '0')}:"
                            "${session.dateTime.minute.toString().padLeft(2, '0')}"
                            "  •  avg ${(session.averageTimeMs / 1000).toStringAsFixed(1)}s/question",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${session.score}/${session.total}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: session.score == session.total
                                      ? Colors.green[700]
                                      : Colors.teal[800],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () => _renameSession(session),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

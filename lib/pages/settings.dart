import 'package:flutter/material.dart';

import 'package:abacus/services/database_service.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final String _settingsText = "Set the puzzle difficulty";

  static const List<String> _difficulties = ['Easy', 'Medium', 'Hard'];

  // null while we're still loading the saved value from the database
  String? _selectedDifficulty;

  @override
  void initState() {
    super.initState();
    _loadDifficulty();
  }

  Future<void> _loadDifficulty() async {
    final fromDB = await DatabaseService.dataServiceInstance.getDifficulty();
    setState(() {
      _selectedDifficulty = fromDB;
    });
  }

  void _selectDifficulty(String difficulty) {
    DatabaseService.dataServiceInstance.setDifficulty(difficulty); // Persists in background
    setState(() {
      _selectedDifficulty = difficulty; // Updates UI immediately
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.teal[800],
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      body: Center(
        child: _selectedDifficulty == null
            ? const CircularProgressIndicator(color: Colors.white)
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                _settingsText,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            for (final difficulty in _difficulties) ...[
              _buildDifficultyButton(difficulty),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(String difficulty) {
    final bool isSelected = difficulty == _selectedDifficulty;

    return ElevatedButton(
      onPressed: () => _selectDifficulty(difficulty),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.teal[900] : null,
        foregroundColor: isSelected ? Colors.white : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          difficulty,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
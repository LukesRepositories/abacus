import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:abacus/model/arithmetic_puzzle/puzzle_session.dart';
import 'package:abacus/services/database_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  List<PuzzleSession> _sessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final sessions = await DatabaseService.dataServiceInstance.getPuzzleSession();
    setState(() {
      _sessions = sessions;
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.teal[800],
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: (){
                    context.pushNamed('about');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "About",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  final session = _sessions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      title: Text('${session.score} / ${session.total}'),
                      subtitle: Text(session.mode),
                      trailing: Text('${session.totalTimeMs} ms'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
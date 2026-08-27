import 'package:flutter/material.dart';

import 'package:abacus/pages/home.dart';
import 'package:abacus/pages/arithmetic_puzzle.dart';
import 'package:abacus/pages/profile.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;

  // A GlobalKey per tab lets us force ArithmeticPuzzle to rebuild
  // (i.e. start a fresh puzzle) whenever the user taps its tab.
  Key _puzzleKey = UniqueKey();

  static const List<String> _titles = ["Home", "Puzzle", "Profile"];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1 && _selectedIndex != 1) {
        // Give a fresh set of questions each time the Puzzle tab is opened.
        _puzzleKey = UniqueKey();
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Home(),
      ArithmeticPuzzle(key: _puzzleKey),
      const Profile(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        backgroundColor: Colors.teal[800],
        indicatorColor: Colors.teal[600],
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.calculate, color: Colors.white),
            label: "Puzzle",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Colors.white70),
            selectedIcon: Icon(Icons.person, color: Colors.white),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

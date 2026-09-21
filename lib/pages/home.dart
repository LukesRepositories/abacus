import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/arithmetic_puzzle');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Puzzle",
                    style: TextStyle(fontSize: 20),
                  ),
                )
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/map');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Map",
                    style: TextStyle(fontSize: 20),
                  ),
                )
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/profile');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Profile",
                    style: TextStyle(fontSize: 20),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
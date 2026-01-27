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
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/maths_puzzle');
                },
                child: const Text("Start")
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/about');
                },
                child: const Text("About")
            ),
          ],
        ),
      ),
    );
  }
}
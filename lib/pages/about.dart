import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  final String _aboutText = "This is a project I am undertaking to both improve my skills and to create something. I have also wanted to make a maths puzzle app for a while now with the idea to extend the scope to make it a social puzzle app with a variety of cerebral puzzles. It is also the case that when facing rejections from job applications I believe I have the capability to somewhat define my own path. I went for a long weekend away to London in January and that reinvigorated me.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Colors.teal[800],
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                _aboutText,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
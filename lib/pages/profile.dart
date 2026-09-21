import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final String _profileText = "This is the profile page.";

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                _profileText,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/about');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "About",
                    style: TextStyle(fontSize: 20),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
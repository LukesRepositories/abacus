import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:abacus/pages/root.dart';
import 'package:abacus/pages/about.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/root',
    routes: {
      '/root': (context) => const Root(),
      '/about': (context) => const About(),
    },
  ));
}
=======
import 'package:abacus/navigation.dart';

void main() => runApp(const AbacusApp());

class AbacusApp extends StatelessWidget {
  const AbacusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Abacus',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.teal[400],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal[800],
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
>>>>>>> slow-develop

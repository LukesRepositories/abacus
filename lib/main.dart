import 'package:flutter/material.dart';
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

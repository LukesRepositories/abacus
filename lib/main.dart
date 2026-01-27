import 'package:flutter/material.dart';
import 'package:abacus/pages/home.dart';
import 'package:abacus/pages/about.dart';
import 'package:abacus/pages/maths_puzzle.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/about': (context) => About(),
      '/maths_puzzle': (context) => MathsPuzzle(),
    },
  ));
}
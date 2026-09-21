import 'package:flutter/material.dart';
import 'package:abacus/pages/home.dart';
import 'package:abacus/pages/about.dart';
import 'package:abacus/pages/arithmetic_puzzle.dart';
import 'package:abacus/pages/profile.dart';
import 'package:abacus/pages/map.dart';
import 'package:abacus/pages/event.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/about': (context) => About(),
      '/arithmetic_puzzle': (context) => ArithmeticPuzzle(),
      '/profile': (context) => Profile(),
      '/map': (context) => Map(),
      '/event': (context) => Event(),
    },
  ));
}
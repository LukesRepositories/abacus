import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:abacus/pages/arithmetic_puzzle.dart';
import 'package:abacus/pages/map.dart';
import 'package:abacus/pages/profile.dart';
import 'package:abacus/pages/about.dart';
import 'package:abacus/pages/event.dart';
import 'package:abacus/widgets/scaffold_with_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/puzzle',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [
        // Branch 0 — Puzzle
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/puzzle',
              builder: (context, state) => const ArithmeticPuzzle(),
            ),
          ],
        ),

        // Branch 1 — Map (with Event pushed on top)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/mapPage',
              builder: (context, state) => const MapPage(),
              routes: [
                GoRoute(
                  path: 'event', // no leading slash → resolves to /map/event
                  name: 'event',
                  builder: (context, state) => const Event(),
                ),
              ],
            ),
          ],
        ),

        // Branch 2 — Profile (with About pushed on top)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const Profile(),
              routes: [
                GoRoute(
                  path: 'about',
                  name: 'about',
                  builder: (context, state) => const About(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
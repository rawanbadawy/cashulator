import 'package:cashulator/screens/calculator/calculator.screen.dart';
import 'package:cashulator/screens/convertor/convertor.screen.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CalculatorScreen(),
    ),
    GoRoute(path: '/convertor', builder:(context, state) => const ConvertorScreen() ,)

  ],
);
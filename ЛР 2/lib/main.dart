import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'one.dart';
import 'second.dart';
import 'third.dart';

// GoRouter конфигурация
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/one',
      builder: (context, state) => const One(),
    ),
    GoRoute(
      path: '/second',
      builder: (context, state) => const Second(),
    ),
    GoRoute(
      path: '/third',
      builder: (context, state) => const Third(),
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа №2',
      
      // Обычные named routes
      routes: {
        '/one': (context) => const One(),
        '/second': (context) => const Second(),
        '/third': (context) => const Third(),
      },
      
      home: const One(),
    );
  }
}
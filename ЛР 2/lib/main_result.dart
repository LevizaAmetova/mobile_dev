import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';
import 'second.dart';
import 'third.dart';

// GoRouter конфигурация
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Main(),
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
        '/': (context) => const Main(),
        '/second': (context) => const Second(),
        '/third': (context) => const Third(),
      },
      
      home: const Main(),
    );
  }
}
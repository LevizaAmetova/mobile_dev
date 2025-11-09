import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'second.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главный экран'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Главный экран',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // 1. Базовая навигация
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Second()),
                );
              },
              child: const Text('Базовая навигация'),
            ),
            const SizedBox(height: 10),
            
            // 2. Named routes
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Named Routes'),
            ),
            const SizedBox(height: 10),
            
            // 3. GoRouter
            ElevatedButton(
              onPressed: () {
                context.push('/second');
              },
              child: const Text('GoRouter'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Третий экран'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Третий экран',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // Разные способы возврата назад
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Назад (базовая)'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Назад (GoRouter)'),
            ),
            const SizedBox(height: 20),
            
            // Навигация на главный экран
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: const Text('На главный (сброс стека)'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('На главный (GoRouter)'),
            ),
          ],
        ),
      ),
    );
  }
}
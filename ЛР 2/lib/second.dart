import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'third.dart';

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Второй экран'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Второй экран',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // Навигация на третий экран
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Third()),
                );
              },
              child: const Text('На третий экран (базовая)'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              child: const Text('На третий экран (named)'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {
                context.push('/third');
              },
              child: const Text('На третий экран (GoRouter)'),
            ),
            const SizedBox(height: 20),
            
            // Возврат назад
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
          ],
        ),
      ),
    );
  }
}
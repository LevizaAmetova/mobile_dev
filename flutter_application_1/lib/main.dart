import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Text 1'),
                    Text('Text 2'),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Text 3'),
                    Text('Text 4'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
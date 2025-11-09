import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';
import 'register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://gxuotdmumaqjjktuarst.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd4dW90ZG11bWFxamprdHVhcnN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI2ODc2NDUsImV4cCI6MjA3ODI2MzY0NX0.VZ775ddj_J0Ji5eGoN4HmbkuunZL6WbTA3IXHvxWOho',
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
      },
    );
  }
}
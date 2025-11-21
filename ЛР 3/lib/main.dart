import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';
import 'register.dart';
import 'user_profile.dart'; // Добавьте импорт страницы профиля

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
      title: 'Auth System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/profile': (context) => const UserProfile(), // Добавьте маршрут профиля
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final _supabase = Supabase.instance.client;
  User? user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAuthState();
    
    // Слушаем изменения состояния аутентификации
    _supabase.auth.onAuthStateChange.listen((AuthState data) {
      final session = data.session;
      setState(() {
        user = session?.user;
        _isLoading = false;
      });
    });
  }

  void _getAuthState() async {
    final currentUser = _supabase.auth.currentUser;
    setState(() {
      user = currentUser;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Возвращаем соответствующую страницу в зависимости от состояния аутентификации
    if (user == null) {
      return const Login(); // или Register(), в зависимости от вашей логики
    } else {
      // Пользователь авторизован - показываем главную страницу или профиль
      return const UserProfile(); // или ваша главная страница
    }
  }
}
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
      title: 'Auth System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
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
      return const Login();
    } else {
      return const MainPage();
    }
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _supabase = Supabase.instance.client;
  String _recognizedText = '';
  bool _isRecording = false;
  bool _isProcessing = false;

  // Функция для начала записи
  void _startRecording() async {
    setState(() {
      _isRecording = true;
      _recognizedText = '';
    });
    
    // TODO: Добавить логику начала записи аудио
    // Это может быть использование пакета для записи аудио
    // Например: audio_recorder, record, или flutter_sound
  }

  // Функция для остановки записи и расшифровки
  void _stopRecordingAndRecognize() async {
    setState(() {
      _isRecording = false;
      _isProcessing = true;
    });

    try {
      // TODO: Заменить на реальную логику распознавания речи
      // Это может быть вызов API (Google Speech-to-Text, Yandex SpeechKit и т.д.)
      
      // Имитация обработки
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _recognizedText = 'Это пример распознанного текста из аудиозаписи. '
            'Здесь будет отображаться текст, полученный в результате расшифровки вашей записи.';
        _isProcessing = false;
      });
      
    } catch (e) {
      setState(() {
        _recognizedText = 'Ошибка при распознавании: $e';
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная страница'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _supabase.auth.signOut();
            },
            tooltip: 'Выйти',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Приветствие
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Добро пожаловать!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Вы вошли как: ${_supabase.auth.currentUser?.email ?? 'Пользователь'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Кнопка записи
            ElevatedButton.icon(
              onPressed: _isRecording ? _stopRecordingAndRecognize : _startRecording,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRecording ? Colors.red : Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              label: Text(
                _isRecording ? 'Остановить запись' : 'Начать запись для расшифровки',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Индикатор процесса
            if (_isProcessing) ...[
              const LinearProgressIndicator(),
              const SizedBox(height: 16),
              const Text(
                'Обработка аудио...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],
            
            // Распознанный текст
            if (_recognizedText.isNotEmpty) ...[
              const Text(
                'Результат расшифровки:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.grey[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _recognizedText,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 20),
            
            // Инструкция
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Как использовать:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('1. Нажмите кнопку "Начать запись для расшифровки"'),
                    Text('2. Говорите четко в микрофон'),
                    Text('3. Нажмите "Остановить запись" для обработки'),
                    Text('4. Получите текстовую расшифровку'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // SELECT - Получить данные пользователя
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        print('❌ Пользователь не авторизован');
        return null;
      }

      final response = await _supabase
          .from('Авторизация / Регистрация')
          .select()
          .eq('email', user.email!)
          .single();

      print('✅ Данные пользователя получены: $response');
      return response;
    } catch (e) {
      print('❌ Ошибка получения данных пользователя: $e');
      return null;
    }
  }

  // INSERT - Создать запись пользователя
  Future<bool> createUserData({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String phoneNumber,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        print('❌ Пользователь не авторизован');
        return false;
      }

      // Преобразуем phoneNumber в int, если это число
      final phoneNumberInt = int.tryParse(phoneNumber) ?? 0;

      final response = await _supabase.from('Авторизация / Регистрация').insert({
        'email': email,
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'date_of_birth': dateOfBirth,
        'phone_number': phoneNumberInt,
        'created_at': DateTime.now().toIso8601String(),
        'is_active': 1,
      });

      print('✅ Данные пользователя созданы: $response');
      return true;
    } catch (e) {
      print('❌ Ошибка создания данных пользователя: $e');
      return false;
    }
  }

  // UPDATE - Обновить данные пользователя
  Future<bool> updateUserData({
    String? username,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? phoneNumber,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        print('❌ Пользователь не авторизован');
        return false;
      }

      Map<String, dynamic> updateData = {};
      
      // Явно преобразуем nullable String в Object
      if (username != null) updateData['username'] = username as Object;
      if (firstName != null) updateData['first_name'] = firstName as Object;
      if (lastName != null) updateData['last_name'] = lastName as Object;
      if (dateOfBirth != null) updateData['date_of_birth'] = dateOfBirth as Object;
      
      // Для phoneNumber преобразуем в int
      if (phoneNumber != null) {
        final phoneNumberInt = int.tryParse(phoneNumber) ?? 0;
        updateData['phone_number'] = phoneNumberInt;
      }

      final response = await _supabase
          .from('Авторизация / Регистрация')
          .update(updateData)
          .eq('email', user.email!);

      print('✅ Данные пользователя обновлены: $response');
      return true;
    } catch (e) {
      print('❌ Ошибка обновления данных пользователя: $e');
      return false;
    }
  }

  // DELETE - Удалить данные пользователя
  Future<bool> deleteUserData() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        print('❌ Пользователь не авторизован');
        return false;
      }

      final response = await _supabase
          .from('Авторизация / Регистрация')
          .delete()
          .eq('email', user.email!);

      print('✅ Данные пользователя удалены: $response');
      return true;
    } catch (e) {
      print('❌ Ошибка удаления данных пользователя: $e');
      return false;
    }
  }

  // SELECT всех пользователей (для админа)
  Future<List<Map<String, dynamic>>> getAllUsers({int limit = 10}) async {
    try {
      final response = await _supabase
          .from('Авторизация / Регистрация')
          .select()
          .order('created_at', ascending: false)
          .limit(limit);

      print('✅ Получено пользователей: ${response.length}');
      return response;
    } catch (e) {
      print('❌ Ошибка получения списка пользователей: $e');
      return [];
    }
  }

  // Альтернативный метод UPDATE с безопасным преобразованием
  Future<bool> updateUserDataSafe({
    String? username,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? phoneNumber,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        print('❌ Пользователь не авторизован');
        return false;
      }

      final updateData = <String, dynamic>{};
      
      // Безопасное добавление значений
      _addIfNotNull(updateData, 'username', username);
      _addIfNotNull(updateData, 'first_name', firstName);
      _addIfNotNull(updateData, 'last_name', lastName);
      _addIfNotNull(updateData, 'date_of_birth', dateOfBirth);
      
      if (phoneNumber != null) {
        updateData['phone_number'] = int.tryParse(phoneNumber) ?? 0;
      }

      if (updateData.isEmpty) {
        print('⚠️ Нет данных для обновления');
        return false;
      }

      final response = await _supabase
          .from('Авторизация / Регистрация')
          .update(updateData)
          .eq('email', user.email!);

      print('✅ Данные пользователя обновлены: $response');
      return true;
    } catch (e) {
      print('❌ Ошибка обновления данных пользователя: $e');
      return false;
    }
  }

  // Вспомогательный метод для безопасного добавления значений
  void _addIfNotNull(Map<String, dynamic> map, String key, String? value) {
    if (value != null && value.isNotEmpty) {
      map[key] = value;
    }
  }

  // Получить данные пользователя по ID
  Future<Map<String, dynamic>?> getUserDataById(String userId) async {
    try {
      final response = await _supabase
          .from('Авторизация / Регистрация')
          .select()
          .eq('id', userId)
          .single();

      print('✅ Данные пользователя по ID получены: $response');
      return response;
    } catch (e) {
      print('❌ Ошибка получения данных пользователя по ID: $e');
      return null;
    }
  }

  // Проверить существование пользователя
  Future<bool> checkUserExists(String email) async {
    try {
      final response = await _supabase
          .from('Авторизация / Регистрация')
          .select()
          .eq('email', email);

      print('✅ Проверка существования пользователя: ${response.isNotEmpty}');
      return response.isNotEmpty;
    } catch (e) {
      print('❌ Ошибка проверки существования пользователя: $e');
      return false;
    }
  }
}
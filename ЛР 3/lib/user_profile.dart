import 'package:flutter/material.dart';
import 'auth_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await _authService.getUserData();
      setState(() {
        _userData = userData;
        _isLoading = false;
      });
      
      if (userData != null) {
        _usernameController.text = userData['username'] ?? '';
        _firstNameController.text = userData['first_name'] ?? '';
        _lastNameController.text = userData['last_name'] ?? '';
        _dateOfBirthController.text = userData['date_of_birth'] ?? '';
        _phoneNumberController.text = userData['phone_number']?.toString() ?? '';
      }
    } catch (e) {
      print('Ошибка загрузки данных профиля: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        // Используем существующий метод updateUserData
        final success = await _authService.updateUserData(
          username: _usernameController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          dateOfBirth: _dateOfBirthController.text,
          phoneNumber: _phoneNumberController.text,
        );

        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Профиль успешно обновлен')),
          );
          setState(() {
            _isEditing = false;
          });
          await _loadUserData(); // Перезагружаем данные
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ошибка обновления профиля')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _cancelEdit() {
    // Восстанавливаем оригинальные значения
    if (_userData != null) {
      _usernameController.text = _userData!['username'] ?? '';
      _firstNameController.text = _userData!['first_name'] ?? '';
      _lastNameController.text = _userData!['last_name'] ?? '';
      _dateOfBirthController.text = _userData!['date_of_birth'] ?? '';
      _phoneNumberController.text = _userData!['phone_number']?.toString() ?? '';
    }
    
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль пользователя'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _toggleEdit,
              tooltip: 'Редактировать',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Аватар и основная информация
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: Text(
                          _userData?['username']?.toString().substring(0, 1).toUpperCase() ?? 
                          _userData?['email']?.toString().substring(0, 1).toUpperCase() ?? 'U',
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _userData?['email'] ?? 'Без email',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Поля формы
                      _buildEditableField(
                        label: 'Имя пользователя',
                        controller: _usernameController,
                        icon: Icons.person,
                        enabled: _isEditing,
                      ),
                      const SizedBox(height: 16),
                      _buildEditableField(
                        label: 'Имя',
                        controller: _firstNameController,
                        icon: Icons.badge,
                        enabled: _isEditing,
                      ),
                      const SizedBox(height: 16),
                      _buildEditableField(
                        label: 'Фамилия',
                        controller: _lastNameController,
                        icon: Icons.badge,
                        enabled: _isEditing,
                      ),
                      const SizedBox(height: 16),
                      _buildEditableField(
                        label: 'Дата рождения',
                        controller: _dateOfBirthController,
                        icon: Icons.cake,
                        enabled: _isEditing,
                        hintText: 'ГГГГ-ММ-ДД',
                      ),
                      const SizedBox(height: 16),
                      _buildEditableField(
                        label: 'Номер телефона',
                        controller: _phoneNumberController,
                        icon: Icons.phone,
                        enabled: _isEditing,
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 30),

                      // Кнопки действий
                      if (_isEditing) ...[
                        ElevatedButton(
                          onPressed: _saveProfile,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            'Сохранить изменения',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: _cancelEdit,
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Отмена'),
                        ),
                      ] else if (_userData == null) ...[
                        ElevatedButton(
                          onPressed: _toggleEdit,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Создать профиль'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool enabled,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
        filled: !enabled,
        fillColor: Colors.grey[100],
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Поле не может быть пустым';
        }
        return null;
      },
    );
  }
}
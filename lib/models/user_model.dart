class UserModel {
  String _email;
  String _password;
  String _fullName;
  String _phone;
  String? _photoUrl;
  bool _isLoggedIn;

  UserModel({
    required String email,
    required String password,
    required String fullName,
    String phone = '',
    String? photoUrl,
    bool isLoggedIn = false,
  }) : _email = email,
       _password = password,
       _fullName = fullName,
       _phone = phone,
       _photoUrl = photoUrl,
       _isLoggedIn = isLoggedIn;

  // ===== GETTERS =====
  String get email => _email;
  String get password => _password;
  String get fullName => _fullName;
  String get phone => _phone;
  String? get photoUrl => _photoUrl;
  bool get isLoggedIn => _isLoggedIn;

  String get initials {
    final parts = _fullName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return _fullName.isNotEmpty ? _fullName[0].toUpperCase() : '?';
  }

  // ===== SETTERS =====
  set email(String value) {
    if (!_isValidEmail(value)) {
      throw Exception('Format email tidak valid');
    }
    _email = value;
  }

  set password(String value) {
    if (value.length < 6) {
      throw Exception('Password minimal 6 karakter');
    }
    _password = value;
  }

  set fullName(String value) {
    if (value.isEmpty) throw Exception('Nama tidak boleh kosong');
    _fullName = value;
  }

  set phone(String value) {
    if (value.isNotEmpty && !RegExp(r'^\d{10,13}$').hasMatch(value)) {
      throw Exception('Nomor HP harus 10-13 digit');
    }
    _phone = value;
  }

  // ===== METHODS =====
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email);
  }

  bool verifyPassword(String input) => _password == input;

  void login() => _isLoggedIn = true;

  void logout() => _isLoggedIn = false;

  Map<String, dynamic> toMap() => {
    'email': _email,
    'fullName': _fullName,
    'phone': _phone,
    'photoUrl': _photoUrl,
  };

  @override
  String toString() => 'UserModel($_fullName, $_email)';
}

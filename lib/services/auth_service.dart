import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser?.isLoggedIn ?? false;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isEmpty || password.isEmpty) return false;

    _currentUser = UserModel(
      email: email,
      password: password,
      fullName: 'Sakarina Harera',
      phone: '08953215931',
      isLoggedIn: true,
    );
    return true;
  }

  void logout() {
    _currentUser?.logout();
    _currentUser = null;
  }
}

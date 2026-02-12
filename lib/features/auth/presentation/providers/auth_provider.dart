import 'package:flutter/material.dart';
import '../../domain/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  AuthStatus _status = AuthStatus.initial;
  AuthStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final List<String> countryCodes = ['+91', '+1', '+44', '+971'];

  Future<bool> login({
    required String countryCode,
    required String phone,
  }) async {
    _status = AuthStatus.loading;
    notifyListeners();

    final result = await authRepository.login(countryCode, phone);

    return result.fold(
      (failure) {
        _status = AuthStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (token) {
        _status = AuthStatus.authenticated;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  void reset() {
    _status = AuthStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }
}

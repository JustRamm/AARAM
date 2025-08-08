import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userToken;
  String? _userName;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userToken => _userToken;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userToken = prefs.getString('userToken');
    _userName = prefs.getString('userName');
    _userEmail = prefs.getString('userEmail');
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // For demo purposes, accept any non-empty credentials
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _userToken = 'demo_token_${DateTime.now().millisecondsSinceEpoch}';
      _userEmail = email;
      _userName = email.split('@')[0]; // Use email prefix as name for demo
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userToken', _userToken!);
      await prefs.setString('userName', _userName!);
      await prefs.setString('userEmail', _userEmail!);
      
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userToken = null;
    _userName = null;
    _userEmail = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  Future<void> loginWithDigiLocker() async {
    // Simulate DigiLocker OAuth flow
    await Future.delayed(const Duration(seconds: 3));
    
    _isLoggedIn = true;
    _userToken = 'digilocker_token_${DateTime.now().millisecondsSinceEpoch}';
    _userEmail = 'user@digilocker.in';
    _userName = 'DigiLocker User';
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userToken', _userToken!);
    await prefs.setString('userName', _userName!);
    await prefs.setString('userEmail', _userEmail!);
    
    notifyListeners();
  }

  Future<void> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    // Simulate API call for signup
    await Future.delayed(const Duration(seconds: 2));
    
    _isLoggedIn = true;
    _userToken = 'signup_token_${DateTime.now().millisecondsSinceEpoch}';
    _userEmail = email;
    _userName = name;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userToken', _userToken!);
    await prefs.setString('userName', _userName!);
    await prefs.setString('userEmail', _userEmail!);
    
    notifyListeners();
  }
} 
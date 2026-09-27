import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepository;

  UserProvider(this.userRepository);

  UserModel? _currentUser;
  bool _isLoading = true;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> getCurrentUser(String userId) async {
    _isLoading = true;
    notifyListeners();

    _currentUser = await userRepository.getUserById(userId);

    _isLoading = false;
    notifyListeners();
  }
}
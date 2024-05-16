import 'package:flutter/material.dart';
import 'package:partyapp/models/user.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';

  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  // void loginUser(BuildContext context) {
  //   // Simulating authentication
  //   final user = User(email: email, password: password);
  //   user.authenticate();
  // }
}

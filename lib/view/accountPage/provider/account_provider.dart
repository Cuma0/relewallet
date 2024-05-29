import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  String? _userName;
  String? _userProfilePic;
  String? _email;
  String? get getUserName => _userName;
  String? get getUserProfilePic => _userProfilePic;
  String? get getEmail => _email;

  void setUserName(String? newUserName) {
    _userName = newUserName;
    notifyListeners();
  }

  void setProfilePic(String? newProfilePic) {
    _userProfilePic = newProfilePic;
    notifyListeners();
  }
  void setEmail(String? newEmail) {
    _email = newEmail;
    notifyListeners();
  }
}

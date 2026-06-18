import 'package:flutter/cupertino.dart';
import 'package:haris_backend/models/user.dart';

class UserProvider extends ChangeNotifier{
  UserModel? _userModel;

  ///set User
  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  ///get User
  UserModel? getUser() => _userModel;
}
import 'package:flutter/material.dart';
import 'validation_item.dart';

class SignupValidation with ChangeNotifier {
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _pass_again = ValidationItem(null, null);
  var pass;
  var email1;
  //Getters
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  ValidationItem get pass_again => _pass_again;
  bool get isValid {
    if (_email.value != null &&
        _password.value != null &&
        _pass_again.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValid1 {
    if (_email.value != null && _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  //Setters
  void changeEmail(String value) {
    if (value.length != 0 && value.contains('@') && value.contains('.')) {
      _email = ValidationItem(value, null);
      email1 = value;
    } else {
      _email = ValidationItem(null, "Don't match email specifications");
    }
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.length >= 6) {
      _password = ValidationItem(value, null);
      pass = value;
    } else {
      _password = ValidationItem(null, "Must be at least 6 characters long");
    }
    notifyListeners();
  }

  void changePasswordConfirmation(String value) {
    if (value == pass) {
      _pass_again = ValidationItem(value, null);
    } else {
      _pass_again = ValidationItem(null, "Password dont match");
    }
    notifyListeners();
  }

  List submitData() {
    return [email1, pass];
  }
}

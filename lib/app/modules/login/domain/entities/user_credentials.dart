import 'package:flutter/foundation.dart';

class UserCredentials {
  final String name;
  final String email;
  final String password;
  final DateTime birthday;

  UserCredentials({this.name, this.birthday, @required this.email, @required this.password});
}

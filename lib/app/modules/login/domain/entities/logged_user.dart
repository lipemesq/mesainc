import 'package:flutter/foundation.dart';

class LoggedUser {
  final String name;
  final String email;
  final DateTime birthday;
  final String token;

  LoggedUser({this.name, @required this.email, this.birthday, @required this.token});
}

import 'package:flutter/foundation.dart';

class LoggedUser {
  final String name;
  final String email;
  final DateTime birthday;

  String token;

  LoggedUser({@required this.name, @required this.email, this.birthday});
}

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';

class UserDataModel extends LoggedUser {
  final String name;
  final String email;
  final DateTime birthday;
  final String token;

  UserDataModel({this.name, @required this.email, this.birthday, @required this.token});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'birthday': birthday?.millisecondsSinceEpoch,
      'token': token,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserDataModel(
      name: map['name'],
      email: map['email'],
      birthday: map['birthday'] != null ? DateTime.fromMillisecondsSinceEpoch(map['birthday']) : null,
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) => UserDataModel.fromMap(json.decode(source));
}

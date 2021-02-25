import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/domain/errors/errors.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataSourceImpl implements LoginDataSource {
  final Dio dio;

  LoginDataSourceImpl(this.dio);

  final String userDataSharedPreferencesKey = "user01";
  final String baseUrl = "https://mesa-news-api.herokuapp.com";

  @override
  Future<LoggedUser> loginWithEmail(UserCredentials credentials) async {
    final loginUrl = baseUrl + "/v1/client/auth/signin";
    final loginQueryParameters = _mountLoginData(credentials);

    Response response = await dio.post(
      loginUrl,
      data: jsonEncode(loginQueryParameters),
    );

    if (response.statusCode == 201) {
      final token = jsonDecode(response.data)['token'] as String;
      if (token != null && token.isNotEmpty) {
        print("Longe");
        final user = UserDataModel(email: credentials.email, token: token);
        print("Mais Longe");
        try {
          await _saveLoggedUser(user);
        } catch (e) {
          print(e);
        }
        print("Final");
        return user;
      }
    }

    return null;
  }

  Map<String, dynamic> _mountLoginData(UserCredentials credentials) {
    return {
      "email": credentials.email,
      "password": credentials.password,
    };
  }

  Future<void> _saveLoggedUser(UserDataModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userDataSharedPreferencesKey, user.toJson());
  }

  @override
  Future<LoggedUser> signUpWithEmail(UserCredentials credentials) async {
    final signUpUrl = baseUrl + "/v1/client/auth/signup";
    final signUpQueryParameters = _mountSignUpData(credentials);

    Response response = await dio.post(
      signUpUrl,
      data: jsonEncode(signUpQueryParameters),
    );

    if (response.statusCode == 201) {
      final token = jsonDecode(response.data)['token'] as String;
      if (token != null && token.isNotEmpty) {
        return LoggedUser(email: credentials.email, token: token);
      }
    }
    return null;
  }

  Map<String, dynamic> _mountSignUpData(UserCredentials credentials) {
    return {
      "name": credentials.name,
      "email": credentials.email,
      "password": credentials.password,
    };
  }

  @override
  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(userDataSharedPreferencesKey);
  }

  @override
  Future<LoggedUser> getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final encodedUserData = sharedPreferences.getString(userDataSharedPreferencesKey);
    UserDataModel userModel = UserDataModel.fromJson(encodedUserData);
    return userModel;
  }
}
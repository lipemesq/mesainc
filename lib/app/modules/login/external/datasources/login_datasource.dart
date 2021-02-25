import 'package:dio/dio.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/user_credentials.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataSourceImpl implements LoginDataSource {
  final String userDataSharedPreferencesKey = "user01";

  final String baseUrl = "https://mesa-news-api.herokuapp.com";

  @override
  Future<LoggedUser> loginWithEmail(UserCredentials credentials) async {
    final loginUrl = baseUrl + "/v1/client/auth/signin";
    final loginQueryParameters = _mountLoginQueryParameters(credentials);

    Response response = await Dio().get(
      loginUrl,
      queryParameters: loginQueryParameters,
    );

    if (response.statusCode == 200) {
      final String token = response.data["token"];
      if (token != null && token.isNotEmpty) {
        return LoggedUser(email: credentials.email, token: token);
      }
    }

    return null;
  }

  Map<String, dynamic> _mountLoginQueryParameters(UserCredentials credentials) {
    return {
      "email": credentials.email,
      "password": credentials.password,
    };
  }

  @override
  Future<LoggedUser> signUpWithEmail(UserCredentials credentials) async {
    final signUpUrl = baseUrl + "/v1/client/auth/signup";
    final signUpQueryParameters = _mountSignUpQueryParameters(credentials);

    Response response = await Dio().get(
      signUpUrl,
      queryParameters: signUpQueryParameters,
    );

    if (response.statusCode == 200) {
      final String token = response.data["token"];
      if (token != null && token.isNotEmpty) {
        return LoggedUser(email: credentials.email, token: token);
      }
    }

    return null;
  }

  Map<String, dynamic> _mountSignUpQueryParameters(UserCredentials credentials) {
    return {
      "name": credentials.name,
      "email": credentials.email,
      "password": credentials.password,
    };
  }

  @override
  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(userDataSharedPreferencesKey);
  }

  @override
  Future<LoggedUser> getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserDataModel userModel = UserDataModel.fromJson(sharedPreferences.getString(userDataSharedPreferencesKey));
    return userModel;
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_local_storage.dart';
import 'package:ps_mesainc/app/modules/login/infra/models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(singleton: false)
class LoginLocalStorageImpl implements LoginLocalStorage {
  final String userDataSharedPreferencesKey = "user01";

  @override
  Future<void> saveLoggedUser(LoggedUser user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(userDataSharedPreferencesKey, (user as UserDataModel).toJson());
  }

  @override
  Future<void> deleteLoggedUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(userDataSharedPreferencesKey);
  }

  @override
  Future<LoggedUser> loadLoggedUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final encodedUserData = sharedPreferences.getString(userDataSharedPreferencesKey);
    UserDataModel userModel = UserDataModel.fromJson(encodedUserData);
    return userModel;
  }
}

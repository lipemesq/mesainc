import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/login/domain/usecases/login_with_email.dart';
import 'package:ps_mesainc/app/modules/login/external/datasources/login_local_storage.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:ps_mesainc/app/modules/login/infra/datasources/login_local_storage.dart';
import 'package:ps_mesainc/app/modules/login/infra/repositories/login_repository.dart';

import 'domain/repositories/login_repository.dart';
import 'external/datasources/login_datasource.dart';
import 'presenter/signup/signup_controller.dart';
import 'presenter/login/login_controller.dart';

import 'package:ps_mesainc/app/modules/login/presenter/signup/signup_page.dart';
import 'package:ps_mesainc/app/modules/login/presenter/login/login_page.dart';
import 'package:ps_mesainc/app/modules/login/presenter/welcome/welcome_controller.dart';
import 'package:ps_mesainc/app/modules/login/presenter/welcome/welcome_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<LoginDataSource>((i) => LoginDataSourceImpl(i.get())),
        Bind<LoginLocalStorage>((i) => LoginLocalStorageImpl()),
        Bind<LoginRepository>((i) => LoginRepositoryImpl(i.get(), i.get())),
        Bind<LoginWithEmail>((i) => LoginWithEmailImpl(i.get())),
        $SignupController,
        $LoginController,
        $WelcomeController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => WelcomePage()),
        ModularRouter(
          "/loginEmail",
          child: (_, args) => LoginPage(),
          transition: TransitionType.downToUp,
        ),
        ModularRouter(
          "/signUp",
          child: (_, args) => SignupPage(),
          transition: TransitionType.downToUp,
        ),
      ];

  static Inject get to => Inject<LoginModule>.of();
}

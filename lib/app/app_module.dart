import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:ps_mesainc/app/app_widget.dart';
import 'package:ps_mesainc/app/modules/core/usar_data.dart';
import 'package:ps_mesainc/app/modules/feed/feed_module.dart';
import 'package:ps_mesainc/app/modules/login/login_module.dart';

import 'modules/login/domain/usecases/signup_with_email.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => SignUpWithEmailImpl(i.get())),
        Bind((i) => UserData()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: LoginModule()),
        ModularRouter("/feed", module: FeedModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

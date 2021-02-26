import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/feed/presenter/feed/feed_controller.dart';
import 'package:ps_mesainc/app/modules/feed/presenter/feed/feed_page.dart';

class FeedModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $FeedController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => FeedPage()),
      ];

  static Inject get to => Inject<FeedModule>.of();
}

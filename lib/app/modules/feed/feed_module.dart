import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/feed/domain/repositories/news_repository.dart';
import 'package:ps_mesainc/app/modules/feed/domain/usecases/get_highlights.dart';
import 'package:ps_mesainc/app/modules/feed/external/datasource/news_datasource.dart';
import 'package:ps_mesainc/app/modules/feed/external/datasource/news_local_storage.dart';
import 'package:ps_mesainc/app/modules/feed/infra/datasources/news_datasource.dart';
import 'package:ps_mesainc/app/modules/feed/infra/datasources/news_local_storage.dart';
import 'package:ps_mesainc/app/modules/feed/infra/repositories/news_repository.dart';
import 'package:ps_mesainc/app/modules/feed/presenter/feed/feed_controller.dart';
import 'package:ps_mesainc/app/modules/feed/presenter/feed/feed_page.dart';

class FeedModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $FeedController,
        Bind<NewsDatasource>((i) => NewsDataSourceImpl(i.get())),
        Bind<NewsLocalStorage>((i) => NewsLocalStorageImpl()),
        Bind<NewsRepository>((i) => NewsRepositoryImpl(i.get(), i.get())),
        Bind<GetHighlights>((i) => GetHighlightsImpl(i.get()))
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => FeedPage()),
      ];

  static Inject get to => Inject<FeedModule>.of();
}

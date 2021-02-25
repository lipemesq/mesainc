import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_page.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/repositories/news_repository.dart';
import 'package:ps_mesainc/app/modules/feed/infra/datasources/news_datasource.dart';
import 'package:ps_mesainc/app/modules/feed/infra/datasources/news_local_storage.dart';

@Injectable(singleton: false)
class NewsRepositoryImpl implements NewsRepository {
  final NewsDatasource datasource;
  final NewsLocalStorage localStorage;

  NewsRepositoryImpl(this.datasource, this.localStorage);

  @override
  Future<Either<Exception, Unit>> favoriteNews(News news) {
    // TODO: implement favoriteNews
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, List<News>>> getHighlights() {
    // TODO: implement getHighlights
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, NewsPage>> getNewsPage(int pageNumber) {
    // TODO: implement getNewsPage
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> unFavoriteNews(News news) {
    // TODO: implement unFavoriteNews
    throw UnimplementedError();
  }
}

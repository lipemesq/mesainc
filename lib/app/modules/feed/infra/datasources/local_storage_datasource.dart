import 'package:dartz/dartz.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';

abstract class NewsLocalStorageDatasource {
  Future<Either<Exception, List<News>>> loadFavoritedNews(String id);

  Future<Either<Exception, Unit>> saveFavoritedNews(String id, List<News> favoritedNews);
}

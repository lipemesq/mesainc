import 'package:dartz/dartz.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_page.dart';

abstract class NewsRepository {
  Future<Either<Exception, List<News>>> getHighlights();

  Future<Either<Exception, NewsPage>> getNewsPage(int pageNumber);

  Future<Either<Exception, Unit>> favoriteNews(News news);

  Future<Either<Exception, Unit>> unFavoriteNews(News news);
}

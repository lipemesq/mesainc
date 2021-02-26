import 'package:dartz/dartz.dart';
import 'package:ps_mesainc/app/modules/feed/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_page.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';

abstract class NewsRepository {
  Future<Either<FeedError, List<News>>> getHighlights(LoggedUser user);

  Future<Either<FeedError, NewsPage>> getNewsPage(int pageNumber, LoggedUser user);

  Future<Either<FeedError, List<News>>> getFavoritedNews();

  Future<Either<FeedError, Unit>> addNewsToFavorites(News news);

  Future<Either<FeedError, Unit>> removeNewsFromFavorites(News news);
}

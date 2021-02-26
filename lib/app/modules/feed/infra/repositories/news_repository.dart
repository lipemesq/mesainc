import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/feed/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_page.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/repositories/news_repository.dart';
import 'package:ps_mesainc/app/modules/feed/infra/datasources/news_datasource.dart';
import 'package:ps_mesainc/app/modules/feed/infra/datasources/news_local_storage.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';

@Injectable(singleton: false)
class NewsRepositoryImpl implements NewsRepository {
  final NewsDatasource datasource;
  final NewsLocalStorage localStorage;

  NewsRepositoryImpl(this.datasource, this.localStorage);

  @override
  Future<Either<FeedError, List<News>>> getFavoritedNews() async {
    try {
      final List<News> favoritedNews = await localStorage.loadFavoritedNews();
      return Right(favoritedNews);
    } catch (e) {
      return Left(ErrorLoadingFavorites());
    }
  }

  @override
  Future<Either<FeedError, Unit>> addNewsToFavorites(News news) async {
    try {
      List<News> actualFavorites = await localStorage.loadFavoritedNews();
      actualFavorites.add(news);
      await localStorage.saveFavoritedNews(actualFavorites);

      return Right(unit);
    } catch (e) {
      return Left(ErrorOnToggleFavorite());
    }
  }

  @override
  Future<Either<FeedError, Unit>> removeNewsFromFavorites(News news) async {
    try {
      List<News> actualFavorites = await localStorage.loadFavoritedNews();
      actualFavorites.remove(news);
      await localStorage.saveFavoritedNews(actualFavorites);

      return Right(unit);
    } catch (e) {
      return Left(ErrorOnToggleFavorite());
    }
  }

  @override
  Future<Either<FeedError, List<News>>> getHighlights(LoggedUser user) async {
    try {
      final highlights = await datasource.getHighlights(user.token);
      if (highlights == null) return Left(ErrorLoadingHighlights());

      return Right(highlights);
    } on FeedError catch (e) {
      return Left(ErrorLoadingHighlights());
    }
  }

  @override
  Future<Either<FeedError, NewsPage>> getNewsPage(int pageNumber, LoggedUser user) async {
    try {
      final newsPage = await datasource.getNewsPage(pageNumber, user.token);
      if (newsPage == null) return Left(ErrorLoadingNews());

      return Right(newsPage);
    } catch (e) {
      return Left(ErrorLoadingNews());
    }
  }
}

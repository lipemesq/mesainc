import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/feed/core/errors/errors.dart';
import 'package:ps_mesainc/app/modules/feed/core/news_favorite_state.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/repositories/news_repository.dart';

abstract class ToggleNewsFavorite {
  Future<Either<Exception, NewsFavoriteState>> call(News news);
}

@Injectable(singleton: false)
class ToggleNewsFavoriteImpl implements ToggleNewsFavorite {
  final NewsRepository repository;

  ToggleNewsFavoriteImpl(this.repository);

  @override
  Future<Either<Exception, NewsFavoriteState>> call(News news) async {
    if (news.favoriteState == NewsFavoriteState.off) {
      final result = await repository.addNewsToFavorites(news);

      if (result.isLeft()) throw ErrorOnToggleFavorite();
      return Right(NewsFavoriteState.on);
    } else {
      final result = await repository.removeNewsFromFavorites(news);
      if (result.isLeft()) throw ErrorOnToggleFavorite();

      return Right(NewsFavoriteState.off);
    }
  }
}

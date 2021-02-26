import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';

abstract class NewsLocalStorage {
  Future<List<News>> loadFavoritedNews();

  Future<void> saveFavoritedNews(List<News> favoritedNews);
}

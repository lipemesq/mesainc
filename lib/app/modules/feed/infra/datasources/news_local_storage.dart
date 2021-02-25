import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';

abstract class NewsLocalStorage {
  Future<List<News>> loadFavoritedNews(String id);

  Future<void> saveFavoritedNews(String id, List<News> favoritedNews);
}

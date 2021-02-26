import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/infra/datasources/news_local_storage.dart';
import 'package:ps_mesainc/app/modules/feed/infra/models/news_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(singleton: false)
class NewsLocalStorageImpl implements NewsLocalStorage {
  final String favoritedNewsSharedPreferencesKey = "fav01";

  @override
  Future<List<News>> loadFavoritedNews() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final encodedNewsList = sharedPreferences.getStringList(favoritedNewsSharedPreferencesKey);
    final newsList = encodedNewsList.map((n) => NewsDataModel.fromJson(n).entity()).toList();

    return newsList;
  }

  @override
  Future<void> saveFavoritedNews(List<News> favoritedNews) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final encodedNewsList = favoritedNews.map((n) => (n as NewsDataModel).toJson()).toList();
    await sharedPreferences.setStringList(favoritedNewsSharedPreferencesKey, encodedNewsList);

    return;
  }
}

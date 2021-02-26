import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_page.dart';

abstract class NewsDatasource {
  Future<List<News>> getHighlights(String userToken);

  Future<NewsPage> getNewsPage(int pageNumber, String userToken);
}

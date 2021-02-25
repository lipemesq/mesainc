import 'package:flutter/foundation.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_pagination.dart';

import 'news.dart';

class NewsPage {
  final List<News> news;
  final NewsPagination pagination;

  NewsPage({@required this.news, @required this.pagination});
}

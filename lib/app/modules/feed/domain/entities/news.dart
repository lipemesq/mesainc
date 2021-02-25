import 'package:ps_mesainc/app/modules/feed/domain/core/news_favorite_state.dart';

class News {
  final String title;
  final String description;
  final String content;
  final String author;
  final DateTime publishedAt;
  final bool highlight;
  final String url;
  final String imageUrl;

  NewsFavoriteState favoriteState;

  News({
    this.title,
    this.description,
    this.content,
    this.author,
    this.publishedAt,
    this.highlight,
    this.url,
    this.imageUrl,
  });
}

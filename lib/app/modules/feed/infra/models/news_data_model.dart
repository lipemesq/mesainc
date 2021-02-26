import 'dart:convert';

import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';

class NewsDataModel extends News {
  final String title;
  final String description;
  final String content;
  final String author;
  final DateTime publishedAt;
  final bool highlight;
  final String url;
  final String imageUrl;

  NewsDataModel({
    this.title,
    this.description,
    this.content,
    this.author,
    this.publishedAt,
    this.highlight,
    this.url,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'author': author,
      'publishedAt': publishedAt?.millisecondsSinceEpoch,
      'highlight': highlight,
      'url': url,
      'imageUrl': imageUrl,
    };
  }

  factory NewsDataModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NewsDataModel(
      title: map['title'] ?? "erro",
      description: map['description'],
      content: map['content'],
      author: map['author'],
      publishedAt: map['published_at'] != null ? DateTime.parse((map['published_at'])) : null,
      highlight: map['highlight'],
      url: map['url'],
      imageUrl: map['image_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsDataModel.fromJson(String source) => NewsDataModel.fromMap(json.decode(source));

  News entity() => this;
}

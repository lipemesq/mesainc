import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_page.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_pagination.dart';
import 'package:ps_mesainc/app/modules/feed/infra/models/news_data_model.dart';
import 'package:ps_mesainc/app/modules/feed/infra/models/pagination_data_model.dart';

class NewsPageDataModel extends NewsPage {
  final List<News> news;
  final NewsPagination pagination;

  NewsPageDataModel({@required this.news, @required this.pagination});

  NewsPage entity() => this;

  Map<String, dynamic> toMap() {
    return {
      'news': news?.map((x) => (x as NewsDataModel)?.toMap())?.toList(),
      'pagination': (pagination as PaginationDataModel)?.toMap(),
    };
  }

  factory NewsPageDataModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NewsPageDataModel(
      news: List<News>.from(map['news']?.map((x) => NewsDataModel.fromMap(x).entity())),
      pagination: PaginationDataModel.fromMap(map['pagination']).entity(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsPageDataModel.fromJson(String source) => NewsPageDataModel.fromMap(json.decode(source));
}

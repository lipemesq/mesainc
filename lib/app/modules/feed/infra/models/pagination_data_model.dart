import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_pagination.dart';

class PaginationDataModel extends NewsPagination {
  final int currentPage;
  final int perPage;
  final int totalPages;
  final int totalItems;

  PaginationDataModel({
    @required this.currentPage,
    @required this.perPage,
    @required this.totalPages,
    @required this.totalItems,
  });

  Map<String, dynamic> toMap() {
    return {
      'currentPage': currentPage,
      'perPage': perPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
    };
  }

  factory PaginationDataModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PaginationDataModel(
      currentPage: map['currentPage'],
      perPage: map['perPage'],
      totalPages: map['totalPages'],
      totalItems: map['totalItems'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationDataModel.fromJson(String source) => PaginationDataModel.fromMap(json.decode(source));

  NewsPagination entity() => this;
}

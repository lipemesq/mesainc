import 'package:flutter/foundation.dart';

class NewsPagination {
  final int currentPage;
  final int perPage;
  final int totalPages;
  final int totalItems;

  NewsPagination({
    @required this.currentPage,
    @required this.perPage,
    @required this.totalPages,
    @required this.totalItems,
  });
}

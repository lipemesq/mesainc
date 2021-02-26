import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_page.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/infra/datasources/news_datasource.dart';
import 'package:ps_mesainc/app/modules/feed/infra/models/news_data_model.dart';
import 'package:ps_mesainc/app/modules/feed/infra/models/pagination_data_model.dart';

class NewsDataSourceImpl implements NewsDatasource {
  final Dio dio;

  NewsDataSourceImpl(this.dio);

  final String baseUrl = "https://mesa-news-api.herokuapp.com";

  final int itemsPerPage = 20;

  @override
  Future<List<News>> getHighlights(String userToken) async {
    final loginUrl = baseUrl + "/v1/client/news/highlights";

    Response response = await dio.get(
      loginUrl,
      options: Options(headers: {"Authorization": userToken}),
    );

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> results = (response.data['data'] as List).cast<Map<String, dynamic>>();
      if (results != null) {
        print(results.runtimeType);
        print(results[1].runtimeType);
        print(results[1]);
        List<NewsDataModel> highlights = [];

        results.forEach((e) {
          final Map<String, dynamic> f = e;
          print(NewsDataModel.fromMap(f).title);
          highlights.add(NewsDataModel.fromMap(f));
        });

        return highlights;
      }
    }

    return null;
  }

  @override
  Future<NewsPage> getNewsPage(int pageNumber, String userToken) async {
    final loginUrl = baseUrl + "/v1/client/news";

    Response encodedResponse = await dio.get(
      loginUrl,
      queryParameters: {
        "current_page": pageNumber,
        "per_page": itemsPerPage,
      },
      options: Options(headers: {"Authorization": userToken}),
    );

    if (encodedResponse.statusCode == 200) {
      final response = jsonDecode(encodedResponse.data);

      final pagination = PaginationDataModel.fromMap(response["pagination"]).entity();

      final encodedNewsList = response['data'] as List<Map<String, dynamic>>;
      final newsList = encodedNewsList.map((e) => NewsDataModel.fromMap(e).entity()).toList();

      final page = NewsPage(news: newsList, pagination: pagination);
      return page;
    }

    return null;
  }
}

//eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NDkwLCJlbWFpbCI6ImxpcGVtZUBob3RtYWlsLmNvbSJ9.O6k3dpF5WQGXuUIXrHWWP09tYjCK9t8CD6Rd1W0m84c

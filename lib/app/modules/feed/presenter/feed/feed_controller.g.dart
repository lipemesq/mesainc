// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $FeedController = BindInject(
  (i) => FeedController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedControllerBase, Store {
  final _$newsAtom = Atom(name: '_FeedControllerBase.news');

  @override
  ObservableList<News> get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(ObservableList<News> value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  final _$highlightsAtom = Atom(name: '_FeedControllerBase.highlights');

  @override
  ObservableList<News> get highlights {
    _$highlightsAtom.reportRead();
    return super.highlights;
  }

  @override
  set highlights(ObservableList<News> value) {
    _$highlightsAtom.reportWrite(value, super.highlights, () {
      super.highlights = value;
    });
  }

  final _$highlightsRequestStatusAtom =
      Atom(name: '_FeedControllerBase.highlightsRequestStatus');

  @override
  RequestStatus get highlightsRequestStatus {
    _$highlightsRequestStatusAtom.reportRead();
    return super.highlightsRequestStatus;
  }

  @override
  set highlightsRequestStatus(RequestStatus value) {
    _$highlightsRequestStatusAtom
        .reportWrite(value, super.highlightsRequestStatus, () {
      super.highlightsRequestStatus = value;
    });
  }

  final _$getHighlightsAsyncAction =
      AsyncAction('_FeedControllerBase.getHighlights');

  @override
  Future getHighlights() {
    return _$getHighlightsAsyncAction.run(() => super.getHighlights());
  }

  @override
  String toString() {
    return '''
news: ${news},
highlights: ${highlights},
highlightsRequestStatus: ${highlightsRequestStatus}
    ''';
  }
}

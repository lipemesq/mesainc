import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/core/usar_data.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/usecases/get_highlights.dart';

part 'feed_controller.g.dart';

@Injectable()
class FeedController = _FeedControllerBase with _$FeedController;

abstract class _FeedControllerBase with Store {
  UserData userData;

  _FeedControllerBase() {
    userData = Modular.get<UserData>();
    getHighlights();
  }

  @observable
  ObservableList<News> news;

  @observable
  ObservableList<News> highlights;

  @observable
  RequestStatus highlightsRequestStatus = RequestStatus.initial;

  @action
  getHighlights() async {
    final doGetHighlights = Modular.get<GetHighlights>();

    highlightsRequestStatus = RequestStatus.waiting;
    final result = await doGetHighlights(userData.loggedUser);
    if (result.isLeft()) {
      highlightsRequestStatus = RequestStatus.error;
    } else {
      highlightsRequestStatus = RequestStatus.completed;
      final newsList = result.getOrElse(() => null);
      highlights = newsList.asObservable();
    }
  }

  String timeFrom(DateTime date) {
    final now = DateTime.now();
    return now.difference(date).inHours.toString();
  }
}

enum RequestStatus {
  initial,
  waiting,
  error,
  completed,
}

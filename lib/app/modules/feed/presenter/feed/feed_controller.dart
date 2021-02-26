import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'feed_controller.g.dart';

@Injectable()
class FeedController = _FeedControllerBase with _$FeedController;

abstract class _FeedControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

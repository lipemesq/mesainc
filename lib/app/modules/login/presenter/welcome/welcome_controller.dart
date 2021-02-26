import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'welcome_controller.g.dart';

@Injectable()
class WelcomeController = _WelcomeControllerBase with _$WelcomeController;

abstract class _WelcomeControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}

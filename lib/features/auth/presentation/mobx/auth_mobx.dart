import 'package:mobx/mobx.dart';
part 'auth_mobx.g.dart';

class AuthMobx = _AuthMobxBase with _$AuthMobx;

abstract class _AuthMobxBase with Store {
  @observable
  bool isLoading = false;
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'global_store.g.dart';

class GlobalStore = _GlobalStore with _$GlobalStore;

abstract class _GlobalStore with Store {
  @observable
  User? currentUser;

  @computed
  User? get getCurrentUser => currentUser;

  @computed
  bool get hasCurrentUser => currentUser != null;

  @action
  void setCurrentUser(User newUser) {
    currentUser = newUser;
  }
}

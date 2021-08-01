// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GlobalStore on _GlobalStore, Store {
  Computed<User?>? _$getCurrentUserComputed;

  @override
  User? get getCurrentUser =>
      (_$getCurrentUserComputed ??= Computed<User?>(() => super.getCurrentUser,
              name: '_GlobalStore.getCurrentUser'))
          .value;
  Computed<bool>? _$hasCurrentUserComputed;

  @override
  bool get hasCurrentUser =>
      (_$hasCurrentUserComputed ??= Computed<bool>(() => super.hasCurrentUser,
              name: '_GlobalStore.hasCurrentUser'))
          .value;

  final _$currentUserAtom = Atom(name: '_GlobalStore.currentUser');

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$_GlobalStoreActionController = ActionController(name: '_GlobalStore');

  @override
  void setCurrentUser(User newUser) {
    final _$actionInfo = _$_GlobalStoreActionController.startAction(
        name: '_GlobalStore.setCurrentUser');
    try {
      return super.setCurrentUser(newUser);
    } finally {
      _$_GlobalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
getCurrentUser: ${getCurrentUser},
hasCurrentUser: ${hasCurrentUser}
    ''';
  }
}

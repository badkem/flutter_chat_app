import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/data/models/peer.dart';
import 'package:flutter_chat_app/data/repositories/store_repositories.dart';

part 'users_state_cubit.dart';

class UserCubit extends Cubit<UsersState> {
  UserCubit(this._storeRepositories) : super(const Initial());

  final StoreRepositories _storeRepositories;

  Stream<List<Peer>> getUsers() {
    return _storeRepositories.getUsers().map((event) {
      return event.docs
          .map((e) => Peer.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
  }
}

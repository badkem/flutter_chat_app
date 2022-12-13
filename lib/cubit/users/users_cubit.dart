import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/data/repositories/store_repositories.dart';

part 'users_state_cubit.dart';

class UserCubit extends Cubit<UsersState> {
  UserCubit(this._storeRepositories) : super(const Loading());

  final StoreRepositories _storeRepositories;

  Stream<QuerySnapshot> getUsers() {
   return _storeRepositories.getUsers();
  }
}

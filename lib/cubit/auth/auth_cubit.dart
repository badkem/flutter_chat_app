import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_app/data/repositories/auth_repositories.dart';
import 'package:flutter_chat_app/data/repositories/store_repositories.dart';

part 'auth_state_cubit.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository, this._storeRepositories)
      : super(const Unauthenticated());

  final AuthRepository _authRepository;
  final StoreRepositories _storeRepositories;

  Future<void> loginWithGoogle() async {
    try {
      emit(const Loading());
      final user = await _authRepository.loginWithGoogle();

      if (user != null) {
        await _storeRepositories.saveUser(user);

        emit(const Authenticated());
      } else {
        emit(const Unauthenticated());
      }

      emit(const Authenticated());
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(const Loading());
      await _authRepository.signOut();
      emit(const Unauthenticated());
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

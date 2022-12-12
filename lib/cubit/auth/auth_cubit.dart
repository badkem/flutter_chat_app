import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat_app/data/repositories/auth_repositories.dart';

part 'auth_state_cubit.dart';

class AuthCubit extends Cubit<AuthState> {

  AuthCubit(this._authRepository) : super(const Unauthenticated());

  final AuthRepository _authRepository;

  Future<void> signInWithGoogle() async {
    try {
      emit(const Loading());
      final user = await _authRepository.loginWithGoogle();

      if (user != null) {
        emit(const Authenticated());
      } else {
        emit(const Unauthenticated());
      }

      emit(const Authenticated());
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class Loading extends AuthState {
  const Loading();
}

class Authenticated extends AuthState {
  const Authenticated();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;
}
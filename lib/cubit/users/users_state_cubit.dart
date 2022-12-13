part of 'users_cubit.dart';

@immutable
abstract class UsersState {
  const UsersState();
}

class Loading extends UsersState {
  const Loading();
}

class Loaded extends UsersState {
  const Loaded(this.users);
  final List<User> users;
}

class Error extends UsersState {
  const Error(this.message);
  final String message;
}
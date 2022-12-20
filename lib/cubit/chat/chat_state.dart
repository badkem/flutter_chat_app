part of 'chat_cubit.dart';

@immutable
abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ChatLoaded extends ChatState {
  // const ChatLoaded(this.messages);
  // final List<Message> messages;

  const ChatLoaded(this.roomId);

  final String? roomId;
}

class ChatError extends ChatState {
  const ChatError(this.message);

  final String message;
}

class Sending extends ChatState {
  const Sending();
}

class Sent extends ChatState {
  const Sent();
}

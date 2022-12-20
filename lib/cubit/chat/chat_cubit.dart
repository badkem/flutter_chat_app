import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/data/models/message.dart';
import 'package:flutter_chat_app/data/repositories/chat_repositories.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatInitial());

  final _chatRepository = ChatRepository();

  String getRoomId(String userId, String peerId) {
    return userId.hashCode > peerId.hashCode
        ? '$userId-$peerId'
        : '$peerId-$userId';
  }

  Future<void> intoRoom({
    required String userId,
    required String peerId,
  }) async {
    try {
      emit(const ChatLoading());
      final roomId = userId.hashCode > peerId.hashCode
          ? '$userId-$peerId'
          : '$peerId-$userId';
      await _chatRepository.intoRoom(roomId: roomId);
      emit(ChatLoaded(roomId));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Stream<List<Message>> getMessages(String? roomId) {
    return _chatRepository.getMessages(roomId).map((event) {
      return event.docs
          .map((e) => Message.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> sendMessage({
    required String? roomId,
    required String senderId,
    required String message,
  }) async {
    try {
      emit(const Sending());
      await _chatRepository.sendMessage(
        roomId: roomId,
        senderId: senderId,
        message: message,
      );
      emit(const Sent());
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}

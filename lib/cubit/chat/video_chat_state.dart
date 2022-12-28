part of 'video_chat_cubit.dart';

@immutable
abstract class VideoChatState {
  const VideoChatState();
}

class Initial extends VideoChatState {
  const Initial();
}

class Loading extends VideoChatState {
  const Loading();
}

class Loaded extends VideoChatState {
  const Loaded({required this.localRenderer, required this.remoteRenderer});

  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
}

class Error extends VideoChatState {
  const Error(this.message);

  final String message;
}

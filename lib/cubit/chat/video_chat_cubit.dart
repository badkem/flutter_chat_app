import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

part 'video_chat_state.dart';

class VideoChatCubit extends Cubit<VideoChatState> {
  VideoChatCubit() : super(const Initial());

  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  Future<void> _getUserMedia() async {
    final mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };

    final stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    _localRenderer.srcObject = stream;
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> initial() async {
    emit(const Loading());

    _initRenderers();
    _getUserMedia();

    emit(Loaded(
      localRenderer: _localRenderer,
      remoteRenderer: _remoteRenderer,
    ));
  }
}

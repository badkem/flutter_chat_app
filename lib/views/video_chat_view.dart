import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/cubit/chat/video_chat_cubit.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoChatView extends StatefulWidget {
  const VideoChatView({Key? key}) : super(key: key);

  @override
  State<VideoChatView> createState() => _VideoChatViewState();
}

class _VideoChatViewState extends State<VideoChatView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Chat'),
      ),
      body: Stack(
        children: [
          BlocConsumer<VideoChatCubit, VideoChatState>(
            listener: (context, state) {
              if (state is Error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is Loaded) {
                return Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: RTCVideoView(state.localRenderer));
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/cubit/chat/chat_cubit.dart';
import 'package:flutter_chat_app/data/models/message.dart';
import 'package:flutter_chat_app/data/models/peer.dart';

import 'package:timeago/timeago.dart' as timeago;

class ChatView extends StatefulWidget {
  const ChatView({Key? key, required this.peer}) : super(key: key);

  final Peer peer;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.read<ChatCubit>().intoRoom(
          userId: FirebaseAuth.instance.currentUser!.uid,
          peerId: widget.peer.uuid,
        );

    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final me = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.peer.photoUrl),
            ),
            const SizedBox(width: 5),
            Text(widget.peer.name)
          ],
        ),
      ),
      body: Center(
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is Sent) {
              _textController.clear();
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          },
          builder: (context, state) {
            final chat = context.read<ChatCubit>();
            final roomId = chat.getRoomId(me!.uid, widget.peer.uuid);

            if (state is ChatLoading) {
              return const CircularProgressIndicator();
            }

            return Column(
              children: [
                Expanded(
                    child: StreamBuilder<List<Message>>(
                        stream: chat.getMessages(roomId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              controller: _scrollController,
                              itemCount: snapshot.data!.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                final message = snapshot.data![index];
                                final isMe = message.senderId == me.uid;

                                return Row(
                                  mainAxisAlignment: isMe
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: isMe
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: isMe
                                                ? Colors.lightBlue
                                                : Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            message.text,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: isMe
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          timeago.format(message.time),
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          if (snapshot.hasError) {
                            return const Text('Something go wrong :(');
                          }

                          return const SizedBox.shrink();
                        })),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            hintText: 'Message here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_textController.text.isNotEmpty) {
                            if (state is Sending) {
                              return;
                            }

                            chat.sendMessage(
                              roomId: roomId,
                              senderId: me.uid,
                              message: _textController.text,
                            );
                          }
                        },
                        icon: const Icon(Icons.send),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

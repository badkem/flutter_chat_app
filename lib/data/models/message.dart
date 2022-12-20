import 'dart:convert';

class Message {
  Message({
    required this.text,
    required this.senderId,
    required this.time,
  });

  factory Message.fromJson(String json) => Message.fromMap(jsonDecode(json));

  factory Message.fromMap(Map<String, dynamic> map) => Message(
        text: map['text'],
        senderId: map['sender'],
        time: map['createdAt'].toDate(),
      );

  final String text;
  final String senderId;
  final DateTime time;

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        'text': text,
        'sender': senderId,
        'createdAt': time.toIso8601String(),
      };
}

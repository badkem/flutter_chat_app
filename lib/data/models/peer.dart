import 'dart:convert';

class Peer {
  Peer({
    required this.uuid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.createdAt,
  });

  factory Peer.fromJson(String json) => Peer.fromMap(jsonDecode(json));

  factory Peer.fromMap(Map<String, dynamic> map) => Peer(
        uuid: map['uid'],
        name: map['name'],
        email: map['email'],
        photoUrl: map['photoUrl'],
        createdAt: map['createdAt'].toDate(),
      );

  final String uuid;
  final String name;
  final String email;
  final String photoUrl;
  final DateTime createdAt;

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        'uid': uuid,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'createdAt': createdAt.toIso8601String(),
      };
}

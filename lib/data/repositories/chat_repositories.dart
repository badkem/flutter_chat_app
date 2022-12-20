import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  static final _store = FirebaseFirestore.instance;

  Future<void> intoRoom({required String roomId}) async {
    try {
      final room = await _store.collection('rooms').doc(roomId).get();

      if (!room.exists) {
        await _store.collection('rooms').doc(roomId).set({
          'uid': roomId,
          'createdAt': DateTime.now(),
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot> getMessages(String? roomId) {
    return _store
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> sendMessage({
    required String? roomId,
    required String senderId,
    required String message,
  }) async {
    await _store.collection('rooms').doc(roomId).collection('messages').add({
      'sender': senderId,
      'text': message,
      'createdAt': DateTime.now(),
    });
  }
}

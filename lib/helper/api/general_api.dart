import 'package:chat_services/models/chat_model.dart';
import 'package:chat_services/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

User get userProvider => auth.currentUser!;

class Apis {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: userProvider.uid)
        .snapshots();
  }

  static Future<bool?> userExists() async {
    return (await firestore.collection('users').doc(userProvider.uid).get())
        .exists;
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      image: userProvider.photoURL.toString(),
      message: 'this is salama',
      name: userProvider.displayName.toString(),
      createdAt: time,
      isOnline: false,
      id: userProvider.uid,
      lastActive: time,
      email: userProvider.email.toString(),
      pushToken: '',
    );

    return await firestore
        .collection('users')
        .doc(userProvider.uid)
        .set(chatUser.toJson());
  }

  static String getChatRoomId(String id) =>
      userProvider.uid.hashCode <= id.hashCode
          ? '${userProvider.uid}_$id'
          : '${id}_${userProvider.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getChatRoomId(user.id)}/messages/')
        .snapshots();
  }

  static Future<void> sendMessage(ChatUser chatUser, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Message message = Message(
      toId: chatUser.id,
      fromId: userProvider.uid,
      msg: msg,
      read: '',
      type: Type.text,
      sent: time,
    );
    final ref =
        firestore.collection('chats/${getChatRoomId(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection(
            'chats/${getChatRoomId(message.fromId.toString())}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
}

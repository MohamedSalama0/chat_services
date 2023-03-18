import 'dart:io';

import 'package:chat_services/models/chat_model.dart';
import 'package:chat_services/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

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

  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Message message = Message(
      toId: chatUser.id,
      fromId: userProvider.uid,
      msg: msg,
      read: '',
      type: type,
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

  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    final ext = file.path.split('.').last;

    final ref = storage.ref().child(
        'images/${getChatRoomId(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('byte Transfared: ${p0.bytesTransferred}');
    });
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }
}

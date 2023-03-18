import 'package:chat_services/helper/api/general_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatScreenProvider =
    ChangeNotifierProvider(((ref) => ChatScreenProvider()));

class ChatScreenProvider extends ChangeNotifier {
  // Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessagesStream() {
  //   return ;
  // }

  String formattedTime(BuildContext context, String time) {
    final data = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(data).format(context);
  }
}

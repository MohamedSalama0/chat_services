import 'dart:developer';
import 'dart:io';

import 'package:chat_services/helper/api/general_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final chatScreenProvider =
    ChangeNotifierProvider.autoDispose(((ref) => ChatScreenProvider()));

class ChatScreenProvider extends ChangeNotifier {
  // Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessagesStream() {
  //   return ;
  // }
  bool emojiToggle = false;

  void toggleEmoji() {
    emojiToggle = !emojiToggle;
    notifyListeners();
  }

  bool isUploading = false;
  uploadImage(user) async {
    final ImagePicker picker = ImagePicker();

    // Picking multiple images
    final List<XFile> images = await picker.pickMultiImage(imageQuality: 70);

    // uploading & sending image one by one
    for (var i in images) {
      log('Image Path: ${i.path}');
      isUploading = true;
      notifyListeners();
      await Apis.sendChatImage(user, File(i.path));
      isUploading = false;
      notifyListeners();
    }
  }

  String formattedTime(BuildContext context, String time) {
    final data = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(data).format(context);
  }
}

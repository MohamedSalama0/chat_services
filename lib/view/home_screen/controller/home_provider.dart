import 'package:chat_services/helper/api/general_api.dart';
import 'package:chat_services/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  late final ChatUser me;

  HomeProvider() {
    getSelfInfo();
  }

  Future getSelfInfo() async {
    // final User user = auth.currentUser!;
    firestore.collection('users').doc(userProvider.uid).get().then((res) async {
      if (res.exists) {
        me = ChatUser.fromJson(res.data()!);
      } else {
        await Apis.createUser().then((value) => getSelfInfo());
      }
    });
  }
}

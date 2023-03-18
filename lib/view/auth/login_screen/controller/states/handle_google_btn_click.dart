import 'dart:developer';
import 'package:chat_services/helper/api/general_api.dart';
import 'package:chat_services/helper/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../home_screen/home_screen.dart';
import '../login_provider.dart';

class HandleGoogelBtnState {
  late final WidgetRef ref;
  late final LoginProvider loginProv;
  HandleGoogelBtnState(this.ref) {
    loginProv = ref.read(loginProvider);
  }
  void click(context) {
    loginProv.signInWithGoogle().then((res) async {
      log('user: ${res.user}');
      log('user: ${res.additionalUserInfo}');
      Navigator.pop(context);
      if (await Apis.userExists() == true) {
        pushReplacement(context, const HomeScreen());
      } else {
        await Apis.createUser().then((value) {
        pushReplacement(context, const HomeScreen());
        });
      }
    });
  }
}

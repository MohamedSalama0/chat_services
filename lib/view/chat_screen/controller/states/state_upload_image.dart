import 'package:chat_services/view/chat_screen/controller/caht_screen_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateUploadImage {
  late final WidgetRef ref;
  StateUploadImage(this.ref);
  void upload(user) async {
    ref.read(chatScreenProvider).uploadImage(user);
  }
}

import 'package:chat_services/helper/api/general_api.dart';
import 'package:chat_services/helper/router/router.dart';
import 'package:chat_services/models/user_model.dart';
import 'package:chat_services/resources/styles.dart';
import 'package:chat_services/view/edit_profile_screen/edit_profile_screen.dart';
import 'package:chat_services/view/home_screen/controller/home_provider.dart';
import 'package:chat_services/widgets/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../chat_screen/chat_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(homeProvider.notifier);
    List<ChatUser> chatUserlist = [];
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.home),
        title: const Text(
          'High Five',
          style: AppStyles.textStyleBold18,
        ),
        actions: [
          IconButton(
              onPressed: () {
                // print(chatUserlist[0].id);
                push(context, EditProfileScreen(prov.me));
              },
              icon: const Icon(Icons.more_vert_rounded)),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: StreamBuilder(
        stream: Apis.getAllUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(color: AppStyles.primaryColor),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data!.docs;
              chatUserlist =
                  data.map((e) => ChatUser.fromJson(e.data())).toList();

              if (chatUserlist.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatUserlist.length,
                  itemBuilder: (context, index) {
                    return ChatUserCard(
                      user: chatUserlist[index],
                      onTap: () {
                        print(chatUserlist[index].id);
                        push(context, ChatScreen(chatUserlist[index]));
                      },
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'No Contact Found ',
                    style: AppStyles.textStyleBoldBlack18,
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:chat_services/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../helper/api/general_api.dart';
import '../../models/chat_model.dart';
import '../../models/user_model.dart';
import '../../widgets/message_card_widget.dart';
import '../home_screen/controller/home_provider.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen(this.user, {super.key});
  final ChatUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var w = MediaQuery.of(context).size.width;
    TextEditingController _textController = TextEditingController();
    List<Message> messageList = [];

    final homeProv = ref.read(homeProvider);
    return Scaffold(
      appBar: AppBar(
        // actions: [Image.network(homeProv.me.image)],
        leadingWidth: w * .70,
        leading: Row(children: [
          SizedBox(
            width: w * .03,
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          SizedBox(
            width: w * .02,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Image.network(homeProv.me.image),
          )
        ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: Apis.getAllMessages(user),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox();
                  // return const Center(
                  //   child: CircularProgressIndicator(color: AppStyles.primaryColor),
                  // );

                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data!.docs;
                    messageList =
                        data.map((e) => Message.fromJson(e.data())).toList();
                    // log(jsonEncode(data[0].data()));
                    // final chatUserlist = [];
                    // messageList.clear();
                    // messageList.add(Message(
                    //     fromId: userProvider.uid,
                    //     type: Type.text,
                    //     msg: "it's salama",
                    //     read: '',
                    //     sent: '10:10',
                    //     toId: 'qwerty'));
                    // messageList.add(Message(
                    //   fromId: 'qwerty',
                    //   type: Type.text,
                    //   msg: "Hi this is new salama",
                    //   read: '',
                    //   sent: '10:10',
                    //   toId: userProvider.uid,
                    // ));

                    if (messageList.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return MessageCard(
                            message: messageList[index],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No Messages Found',
                          style: AppStyles.textStyleBoldBlack18,
                        ),
                      );
                    }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            color: AppStyles.primaryColor,
                            icon: const Icon(Icons.emoji_emotions_rounded)),
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.multiline,
                          controller: _textController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'type somthing...',
                            hintStyle: TextStyle(color: AppStyles.blue),
                          ),
                        )),
                        IconButton(
                            onPressed: () {},
                            color: AppStyles.blue,
                            icon: const Icon(Icons.image)),
                        IconButton(
                            onPressed: () {},
                            color: AppStyles.blue,
                            icon: const Icon(Icons.camera)),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  color: AppStyles.greenColor,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  child:
                      const Icon(Icons.send, color: AppStyles.white, size: 26),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      Apis.sendMessage(user, _textController.text);
                      _textController.text = '';
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:chat_services/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({super.key, required this.user, required this.onTap});
  final ChatUser user;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: w * .05, vertical: h * .02),
      color: const Color.fromARGB(255, 190, 203, 211),
      // height: h * .010,
      // width: w * .10,

      child: InkWell(
        onTap: () {
          onTap();
        },
        child: ListTile(
          title: Text(user.name),
          subtitle: Text(user.message),
          leading: user.image.isNotEmpty
              ? CircleAvatar(child: Image.network(user.image))
              : const CircleAvatar(child: Icon(Icons.person)),
          trailing: const Text('03:30'),
        ),
      ),
      //  Row(
      //   children: [
      //     ,
      //     Column(
      //       children: [
      //         ,
      //         const ,
      //       ],
      //     ),
      //     const Expanded(
      //       child: SizedBox(),
      //     ),
      //     const Text('05:30'),
      //   ],
      // ),
    );
  }
}

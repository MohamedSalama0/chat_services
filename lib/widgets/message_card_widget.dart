import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_services/resources/styles.dart';
import 'package:chat_services/view/chat_screen/controller/caht_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/api/general_api.dart';
import '../models/chat_model.dart';

class MessageCard extends ConsumerWidget {
  const MessageCard({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return userProvider.uid == message.fromId
        ? _greenMessage(h, w, ref, context)
        : _blueMessage(h, w, ref, context);
  }

  Widget _greenMessage(h, w, WidgetRef ref, BuildContext context) {
    if (message.read!.isEmpty) {
      Apis.updateMessageReadStatus(message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (message.read!.isNotEmpty)
          const Icon(Icons.done_all_rounded, color: AppStyles.blue),
        SizedBox(width: w * .03),
        Text(
          ref
              .read(chatScreenProvider)
              .formattedTime(context, message.sent.toString()),
          style: AppStyles.textStyleSemiBold14,
        ),
        SizedBox(width: w * .02),
        Flexible(
          child: Container(
              padding: EdgeInsets.all(
                  message.type == Type.image ? w * .03 : w * .04),
              decoration: BoxDecoration(
                color: AppStyles.greenColor,
                borderRadius: BorderRadius.circular(14),
              ),
              margin:
                  EdgeInsets.symmetric(horizontal: w * .05, vertical: h * .05),
              child: message.type == Type.text
                  ? Text(
                      message.msg.toString(),
                      style: AppStyles.textStyleBoldWhite18,
                    )
                  : 
                  // Image.network('${message.msg}')
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: message.msg.toString(),
                    placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image, size: 70),
                  ),
                ),

              ),
        ),
      ],
    );
  }

  Widget _blueMessage(h, w, WidgetRef ref, BuildContext context) {
    if (message.read!.isEmpty) {
      Apis.updateMessageReadStatus(message);
      log('message red updated');
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(w * .04),
            decoration: BoxDecoration(
              color: AppStyles.blue,
              borderRadius: BorderRadius.circular(14),
            ),
            margin:
                EdgeInsets.symmetric(horizontal: w * .05, vertical: h * .05),
            child: Text(
              message.msg.toString(),
              style: AppStyles.textStyleBoldWhite18,
            ),
          ),
        ),
        SizedBox(width: w * .02),
        Text(
          ref
              .read(chatScreenProvider)
              .formattedTime(context, message.sent.toString()),
          style: AppStyles.textStyleSemiBold14,
        ),
        SizedBox(width: w * .03),
        if (message.read!.isNotEmpty)
          const Icon(Icons.done_all_rounded, color: AppStyles.blue),
      ],
    );
  }
}

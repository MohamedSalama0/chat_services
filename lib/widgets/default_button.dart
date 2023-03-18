import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../resources/styles.dart';
import '../view/auth/login_screen/controller/states/handle_google_btn_click.dart';

Widget defaultButton(
  context, {
  required String image,
  required String text,
  required Function onTap,
}) {
  var h = MediaQuery.of(context).size.height;
  var w = MediaQuery.of(context).size.width;
  return Consumer(
    builder: (context, ref, child) {
      return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          height: h * .080,
          width: w * .80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: AppStyles.primaryColor,
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    width: w * .08,
                  ),
                  SizedBox(
                    width: w * .04,
                  ),
                  Text(
                    text,
                    style: AppStyles.textStyleBoldWhite20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

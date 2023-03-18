import 'package:chat_services/resources/assets_manager/assets_manager.dart';
import 'package:chat_services/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/default_button.dart';
import 'controller/states/handle_google_btn_click.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'High five',
              style: AppStyles.textStyleSemiBoldPrim24,
            ),
          ),
          SizedBox(
            height: h * .10,
          ),
          Image.asset(AssetManager.logo),
          SizedBox(
            height: h * .20,
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return defaultButton(
                context,
                text: 'Login with Google',
                image: AssetManager.google,
                onTap: () {
                  HandleGoogelBtnState(ref).click(context);
                },
              );
            },
          ),
        ],
      ),
    ));
  }
}

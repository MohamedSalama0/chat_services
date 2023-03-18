import 'package:chat_services/helper/api/general_api.dart';
import 'package:chat_services/helper/router/router.dart';
import 'package:chat_services/resources/assets_manager/assets_manager.dart';
import 'package:chat_services/view/auth/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../home_screen/home_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (auth.currentUser != null) {
        pushReplacement(context, const HomeScreen());
      }else{
        pushReplacement(context, const LoginScreen());

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AssetManager.logo)),
    );
  }
}

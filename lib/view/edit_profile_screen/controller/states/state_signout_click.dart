import 'package:chat_services/helper/router/router.dart';
import 'package:chat_services/view/auth/login_screen/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../helper/api/general_api.dart';

class SignOutState {
  void click(context) async {
    await auth.signOut().then((value) {
      GoogleSignIn().signOut().then((value) {
        pushReplacement(context, const LoginScreen());
      });
    });
  }
}

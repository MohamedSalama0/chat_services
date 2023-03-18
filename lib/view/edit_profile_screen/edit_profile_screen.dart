import 'package:chat_services/helper/api/general_api.dart';
import 'package:chat_services/resources/assets_manager/assets_manager.dart';
import 'package:chat_services/resources/styles.dart';
import 'package:chat_services/widgets/default_button.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'controller/states/state_signout_click.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen(
    this.user, {
    super.key,
  });
  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: h * .10),
            user.image.isNotEmpty
                ? CircleAvatar(
                    child: Image.network(
                      user.image,
                    ),
                  )
                : CircleAvatar(
                    radius: w * .20,
                    child: Icon(
                      Icons.person,
                      size: w * .25,
                    ),
                  ),
            SizedBox(height: h * .05),
            Container(
              color: Colors.grey,
              child: Text(
                auth.currentUser!.email.toString(),
                style: AppStyles.textStyleBoldWhite18,
              ),
            ),
            SizedBox(height: h * .05),
            Container(
              color: Colors.grey,
              child: Text(
                auth.currentUser!.displayName.toString(),
                style: AppStyles.textStyleBoldWhite18,
              ),
            ),
            SizedBox(height: h * .10),
            defaultButton(
              context,
              image: AssetManager.logo,
              text: 'Logout',
              onTap: () {
                SignOutState().click(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

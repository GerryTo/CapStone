import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/profile/viewmodel/profile_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          final uid = Provider.of<CurrentUserInfo>(
            context,
            listen: false,
          ).id;

          final phone = Provider.of<ProfileViewModel>(
            context,
            listen: false,
          ).user?.phone;

          if (uid == null) {
            Routes.router.navigateTo(context, Routes.login);
          } else if (phone == null) {
            return;
          } else {
            _launchPhone(phone);
          }
        },
        child: Wrap(
          children: const [
            Text('kontak', style: TextStyle(color: Colors.white)),
            SizedBox(width: 10),
            Icon(
              Icons.contacts,
              color: Colors.white,
              size: 20.0,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF0B3D66),
          elevation: 0,
        ),
      ),
    );
  }

  _launchPhone(String phoneNumber) {
    final Uri contact = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    launch(contact.toString());
  }
}

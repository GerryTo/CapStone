import 'package:capstone/modules/profile/viewmodel/profile_viewmodel.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            final Uri contact = Uri(
              scheme: 'tel',
              path: Provider.of<ProfileViewModel>(context, listen: false)
                  .user
                  ?.phone,
            );
            launch(contact.toString());
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
      ),
    );
  }
}

import 'package:capstone/modules/profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ShareProfileButton extends StatelessWidget {
  const ShareProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _share(context),
        child: Wrap(
          children: [
            Text(
              'Bagikan',
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.share,
              color: Theme.of(context).iconTheme.color,
              size: 20.0,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            side: BorderSide(
                color:
                    Theme.of(context).textTheme.button?.color ?? Colors.grey),
            primary: Colors.transparent,
            elevation: 0),
      ),
    );
  }

  void _share(BuildContext context) {
    final name = Provider.of<ProfileViewModel>(
      context,
      listen: false,
    ).user?.name;
    final company = Provider.of<ProfileViewModel>(
      context,
      listen: false,
    ).user?.company;
    Share.share(
      'Halo, Saya $name\ndari $company\nKamu bisa cek profil ku di Gazebo',
    );
  }
}

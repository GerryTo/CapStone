import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => Routes.router.navigateTo(context, Routes.editProfile),
        child: Wrap(
          children: [
            Text('Edit Profil',
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            Icon(
              Icons.edit,
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
}

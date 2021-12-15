import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/settings/provider/theme_notifier.dart';
import 'package:capstone/modules/settings/viewmodel/settings_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setelan',
          style: GoogleFonts.roboto(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.user == null) {
            return ListView(
              children: const [
                DarkModeSettingTile(),
                AboutTile(),
                LoginTile(),
              ],
            );
          } else if (viewModel.user?.role == 'Architect') {
            return ListView(
              children: [
                const EditProfileTile(),
                const AddProjectTile(),
                const AccountSettingTile(),
                const DarkModeSettingTile(),
                const AboutTile(),
                LogoutTile(auth: _auth),
              ],
            );
          } else {
            return ListView(
              children: [
                const EditProfileTile(),
                const AccountSettingTile(),
                const DarkModeSettingTile(),
                const AboutTile(),
                LogoutTile(auth: _auth),
              ],
            );
          }
        },
      ),
    );
  }
}

class LoginTile extends StatelessWidget {
  const LoginTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.login,
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text('Login'),
      onTap: () => Routes.router.navigateTo(context, Routes.login),
    );
  }
}

class AddProjectTile extends StatelessWidget {
  const AddProjectTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Tambah Proyek', style: TextStyle(fontSize: 18)),
      leading: Icon(
        Icons.add_circle,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () => Routes.router.navigateTo(context, Routes.addProject),
    );
  }
}

class EditProfileTile extends StatelessWidget {
  const EditProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(context.watch<SettingsViewModel>().user?.name ?? 'no name'),
        leading: AspectRatio(aspectRatio: 1, child: _avatar(context)),
        onTap: () async {
          Routes.router.navigateTo(context, Routes.editProfile).then((value) {
            return context.read<CurrentUserInfo>().getUserData();
          });
        },
        trailing: Icon(
          Icons.edit,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }

  Widget _avatar(BuildContext context) {
    final avatarUrl = context.watch<SettingsViewModel>().user?.avatarUrl;
    if (avatarUrl == null) {
      return Container(
        color: Colors.grey,
        child: const Icon(Icons.person),
      );
    }
    return CachedNetworkImage(
      imageUrl: avatarUrl,
      height: 64,
      width: 64,
      fit: BoxFit.fitHeight,
    );
  }
}

class LogoutTile extends StatelessWidget {
  const LogoutTile({
    Key? key,
    required FirebaseAuth auth,
  })  : _auth = auth,
        super(key: key);

  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Logout',
          style: TextStyle(color: Colors.red, fontSize: 18)),
      leading: const Icon(
        Icons.logout,
        color: Colors.red,
      ),
      onTap: () {
        Alert(
          context: context,
          style: AlertStyle(
            isCloseButton: false,
            animationType: AnimationType.grow,
            titleStyle: TextStyle(
              color: Theme.of(context).textTheme.button?.color ?? Colors.grey,
            ),
            descStyle: TextStyle(
              color: Theme.of(context).textTheme.button?.color ?? Colors.grey,
            ),
          ),
          type: AlertType.info,
          title: "LOG OUT",
          desc: "kamu yakin log out dari Gazebo ?",
          buttons: [
            DialogButton(
              child: const Text(
                "Tidak",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: const Color(0xffF23535),
              onPressed: () => Navigator.pop(context),
              width: 120,
            ),
            DialogButton(
                child: const Text(
                  "Ya",
                  style: TextStyle(fontSize: 20),
                ),
                border: Border.all(
                    color: Theme.of(context).textTheme.button?.color ??
                        Colors.grey,
                    width: 1),
                color: Colors.transparent,
                onPressed: () async {
                  await _auth.signOut();
                  context.read<CurrentUserInfo>().clearUserData();
                  Routes.router.navigateTo(
                    context,
                    Routes.home,
                    clearStack: true,
                  );
                })
          ],
        ).show();
      },
    );
  }
}

class AboutTile extends StatelessWidget {
  const AboutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Tentang', style: TextStyle(fontSize: 18)),
      leading: Icon(
        Icons.info,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {},
    );
  }
}

class DarkModeSettingTile extends StatelessWidget {
  const DarkModeSettingTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text('Mode Gelap', style: TextStyle(fontSize: 18)),
        leading: Icon(
          Icons.dark_mode,
          color: Theme.of(context).iconTheme.color,
        ),
        trailing: DropdownButton(
          onChanged: (themeMode) => context
              .read<ThemeNotifier>()
              .saveThemePref(themeMode as ThemeMode),
          value: context.watch<ThemeMode>(),
          items: const [
            DropdownMenuItem(
              child: Text('Setelan sistem'),
              value: ThemeMode.system,
            ),
            DropdownMenuItem(
              child: Text('Gelap'),
              value: ThemeMode.dark,
            ),
            DropdownMenuItem(
              child: Text('Cerah'),
              value: ThemeMode.light,
            )
          ],
        ));
  }
}

class AccountSettingTile extends StatelessWidget {
  const AccountSettingTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Setelan Akun', style: TextStyle(fontSize: 18)),
      leading: Icon(
        Icons.person,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () => Routes.router.navigateTo(context, Routes.accountSettings),
    );
  }
}

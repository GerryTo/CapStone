import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setelan'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Setelan Akun'),
            leading: const Icon(Icons.person),
            onTap: () =>
                Routes.router.navigateTo(context, Routes.accountSettings),
          ),
          ListTile(
            title: const Text('Mode Gelap'),
            leading: const Icon(Icons.dark_mode),
            trailing: Switch(
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              value: isDarkMode,
            ),
          ),
          ListTile(
            title: const Text('Tentang'),
            leading: const Icon(Icons.info),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/config/themes/app_input_decoration.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setelan Akun'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: ListView(
          children: [
            const TextField(
              decoration: InputDecoration(
                label: Text('Nama'),
                focusedBorder: inputFocusBorder,
                enabledBorder: inputEnabledBorder,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                label: Text('Nama Perusahaan'),
                focusedBorder: inputFocusBorder,
                enabledBorder: inputEnabledBorder,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                label: Text('email'),
                focusedBorder: inputFocusBorder,
                enabledBorder: inputEnabledBorder,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                label: Text('password'),
                focusedBorder: inputFocusBorder,
                enabledBorder: inputEnabledBorder,
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                label: Text('telepon'),
                focusedBorder: inputFocusBorder,
                enabledBorder: inputEnabledBorder,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: const Text('Konfirmasi'))
          ],
        ),
      ),
    );
  }
}

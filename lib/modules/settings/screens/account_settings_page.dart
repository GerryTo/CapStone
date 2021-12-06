import 'dart:developer';

import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/config/themes/app_input_decoration.dart';
import 'package:capstone/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _passwordConfirmController = TextEditingController();

  AccountSettingsPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setelan Akun'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(builder: (context) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(_auth.currentUser?.email ?? ''),
                onTap: () => _showEditEmailSheet(context),
                trailing: const Icon(Icons.edit),
              ),
              ListTile(
                leading: const Icon(Icons.password),
                title: const Text('Password'),
                onTap: () => _showEditPasswordSheet(context),
                trailing: const Icon(Icons.edit),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _showEditEmailSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // ignore: prefer_const_constructors
        return EditDataModalBottomSheet(
          fields: [
            TextFormField(
              validator: validateEmail,
              decoration: const InputDecoration(label: Text('Email Baru')),
              controller: _emailController,
            )
          ],
          onSubmit: () async {
            try {
              await _updateEmail(context);
            } on FirebaseAuthException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message ?? ''),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<void> _updateEmail(BuildContext context) async {
    await _auth.currentUser?.updateEmail(_emailController.text).then((value) {
      Routes.router.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil update email'),
        ),
      );
    });
  }

  void _showEditPasswordSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        // ignore: prefer_const_constructors
        return EditDataModalBottomSheet(
          fields: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Password Baru')),
              controller: _passwordController,
              obscureText: true,
              validator: (val) =>
                  _passwordController.text != _passwordConfirmController.text
                      ? 'Password tidak sama!'
                      : null,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(label: Text('Konfirmasi Password')),
              obscureText: true,
              controller: _passwordConfirmController,
              validator: (val) =>
                  _passwordController.text != _passwordConfirmController.text
                      ? 'Password tidak sama!'
                      : null,
            )
          ],
          onSubmit: () async {
            try {
              await _auth.currentUser?.updatePassword(_passwordController.text);
            } on FirebaseAuthException catch (e) {
              log(e.message!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message ?? ''),
                ),
              );
            } on Exception catch (e) {
              log(e.toString());
            }
          },
        );
      },
    );
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    return !regex.hasMatch(value ?? '') ? 'Enter a valid email address' : null;
  }
}

class EditDataModalBottomSheet extends StatelessWidget {
  const EditDataModalBottomSheet({
    required this.onSubmit,
    required this.fields,
    Key? key,
  }) : super(key: key);

  final void Function() onSubmit;

  final List<Widget> fields;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...fields,
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Routes.router.pop(context);
                    },
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        onSubmit();
                      }
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

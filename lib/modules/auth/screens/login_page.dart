import 'dart:developer';

import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus(context);
  }

  void checkLoginStatus(BuildContext context) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        //navigate ke home apabila user telah login
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          Routes.router.navigateTo(context, Routes.home, replace: true);
        });
      }
    } on Exception catch (e) {
      log(e.toString());
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gazebo',
                      style: TextStyle(
                        fontSize: 96,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: const Text('Email',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 10),
                  _emailField(context),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: const Text('Kata Sandi',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 10),
                  _passwordField(context),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton(
                      onPressed: () {
                        _login(context);
                      },
                      child: const Text('Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () =>
                        Routes.router.navigateTo(context, Routes.registration),
                    child: const Text(
                      'Belum punya akun? Daftar disini',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextField(
              controller: _emailController,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Email@email.com',
                hintStyle:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              obscuringCharacter: "*",
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: 'Masukkan kata sandi',
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )),
              onSubmitted: (value) {},
            ),
          ),
        ),
      ],
    );
  }

  void _login(BuildContext context) async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Routes.router.navigateTo(context, Routes.home, replace: true);
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
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
                children: const [
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
                  emailBar(context),
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
                  passwordBar(context),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Routes.router.navigateTo(context, Routes.home,replace: true);
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

  Widget emailBar(BuildContext context) {
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

  Widget passwordBar(BuildContext context) {
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
}

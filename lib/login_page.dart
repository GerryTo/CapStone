import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0B3D66),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              SizedBox(height: 70),
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
              SizedBox(height: 40),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text('Email',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(height: 10),
                  emailBar(context),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text('Kata Sandi',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(height: 10),
                  passwordBar(context),
                  SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                  ),
                  SizedBox(height: 40),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Belum punya akun? Daftar disini',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ));
  }

  Widget emailBar(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Email@email.com',
                  hintStyle: TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget passwordBar(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                obscureText: !_passwordVisible,
                obscuringCharacter: "*",
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: 'Masukkan kata sandi',
                    hintStyle: TextStyle(
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
      ),
    );
  }
}

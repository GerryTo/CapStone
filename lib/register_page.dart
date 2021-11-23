import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0B3D66),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Gazebo',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text('Nama',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Nama Lengkap',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text('Nama Perusahaan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Nama Perusahaan',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Email@email.com',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text('Kata Sandi',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 10),
                      passwordBar(context),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text('Lokasi',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DropdownButton(
                                  items: const [],
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text('Nomor Telepon',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextField(
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: '+62',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                                onSubmitted: (value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          SafeArea(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
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
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
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
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              onSubmitted: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}

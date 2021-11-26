import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/constants/city_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _passwordVisible;
  String? city;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Gazebo',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text(
                          'Nama',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _nameField(context),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text(
                          'Nama Perusahaan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _companyField(context),
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
                      _emailField(context),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text(
                          'Kata Sandi',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      passwordBar(context),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text(
                          'Lokasi',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _locationField(context),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text(
                          'Nomor Telepon',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _phoneField(context),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: ElevatedButton(
                          onPressed: () {
                            _register();
                          },
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

  Row _phoneField(BuildContext context) {
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
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: '+62',
                hintStyle:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              controller: _phoneController,
              onSubmitted: (value) {},
            ),
          ),
        ),
      ],
    );
  }

  Row _emailField(BuildContext context) {
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
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Email@email.com',
                hintStyle:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                border: InputBorder.none,
              ),
              controller: _emailController,
              onSubmitted: (value) {},
            ),
          ),
        ),
      ],
    );
  }

  Row _companyField(BuildContext context) {
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
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Nama Perusahaan',
                hintStyle:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                border: InputBorder.none,
              ),
              controller: _companyController,
              onSubmitted: (value) {},
            ),
          ),
        ),
      ],
    );
  }

  Row _nameField(BuildContext context) {
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
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Nama Lengkap',
                hintStyle:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {},
              controller: _nameController,
            ),
          ),
        ),
      ],
    );
  }

  Row _locationField(BuildContext context) {
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
            child: DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Pilih kota atau kabupaten'),
              value: city,
              onChanged: (city) => this.city = city,
              items: List.generate(
                citiesData.length,
                (index) => DropdownMenuItem(
                  value: citiesData[index],
                  child: Text(
                    citiesData[index],
                  ),
                ),
              ),
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
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
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

  void _register() async {
    _auth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
  }
}

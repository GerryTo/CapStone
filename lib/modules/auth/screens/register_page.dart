import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/constants/city_names.dart';
import 'package:capstone/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _passwordVisible;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _cityController = TextEditingController();

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
                          onPressed: _onRegisterButtonClicked,
                          child: const Text(
                            'Daftar',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
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

  AlertDialog _registerSuccessDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Berhasil Mendaftar.'),
      content: const Text('Anda telah berhasil mendaftar.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Routes.router.pop(context),
          child: const Text('Oke'),
        )
      ],
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
            child: TypeAheadField<String>(
              textFieldConfiguration: TextFieldConfiguration(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    hintText: 'Kota asal',
                    hintStyle: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    border: InputBorder.none,
                  )),
              suggestionsCallback: (pattern) {
                return citiesData.where((element) =>
                    element.toLowerCase().contains(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                _cityController.text = suggestion;
              },
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
                    setState(
                      () {
                        _passwordVisible = !_passwordVisible;
                      },
                    );
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

  Future<void> _register(BuildContext context) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      final uid = userCred.user?.uid;
      if (uid != null) {
        _firestore.collection('users').doc(uid).set({
          'avatar_url': null,
          'name': _nameController.text,
          'company': _companyController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'location': _cityController.text,
          'projects': [],
        });
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => _registerSuccessDialog(context),
        ).then(
          (_) => Routes.router.pop(context),
        );
      }
    } on FirebaseAuthException catch (e) {
      var error = e.toString();
      var splitErrorMassage = error.split("] ");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            splitErrorMassage[1],
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
    } on Exception catch (e) {
      var error = e.toString();
      var splitErrorMassage = error.split("] ");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            splitErrorMassage[1],
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  @override
  void dispose() {
    _companyController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onRegisterButtonClicked() async {
    final bool isAllFieldFilled = _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _companyController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _cityController.text.isEmpty;

    if (isAllFieldFilled) {
      _fieldEmptyDialog().show();
    } else {
      await _register(context);
    }
  }

  Alert _fieldEmptyDialog() {
    return Alert(
      context: context,
      style: const AlertStyle(
        isCloseButton: false,
        animationType: AnimationType.grow,
      ),
      type: AlertType.error,
      title: "GAGAL REGISTER",
      desc: "Yakin sudah semua di isi?",
      buttons: [
        DialogButton(
          child: const Text(
            "Kembali",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    );
  }
}

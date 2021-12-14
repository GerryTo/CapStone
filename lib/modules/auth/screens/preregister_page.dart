import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreregisterPage extends StatelessWidget {
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
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: const Text(
                        'Hai, selamat datang di Gazebo. kamu disini ingin menjadi apa ?',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: () {
                        Routes.router
                            .navigateTo(context, Routes.registrationClient);
                      },
                      child: Text(
                        "Saya ingin menjadi pengguna",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          primary: Colors.transparent,
                          elevation: 0)),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: () {
                        Routes.router
                            .navigateTo(context, Routes.registrationArchitect);
                      },
                      child: Text(
                        "Saya ingin menjadi arsitek",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          primary: Colors.transparent,
                          elevation: 0)),
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
}

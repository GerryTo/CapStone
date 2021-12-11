import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileEmptyFeed extends StatelessWidget {
  const ProfileEmptyFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        Opacity(
            opacity: 0.4,
            child: SvgPicture.asset(
              'assets/empty.svg',
              width: 220,
              height: 220,
            )),
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
        const Text(
          'Project belum ada,\n Ayo unggah projek mu sekarang',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
      ],
    );
  }
}

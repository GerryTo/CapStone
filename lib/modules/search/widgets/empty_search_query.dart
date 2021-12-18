import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptySearchQuery extends StatelessWidget {
  const EmptySearchQuery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.4,
            child: SvgPicture.asset(
              'assets/search.svg',
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Kamu mau cari apa nih ?',
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontFamily: 'ReadexPro'),
            textAlign: TextAlign.center,
          ),
          //
        ],
      ),
    );
  }
}

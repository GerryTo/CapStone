import 'package:capstone/modules/auth/model/user.dart';
import 'package:flutter/material.dart';

class ProfileDetailWidget extends StatelessWidget {
  const ProfileDetailWidget(this.user, {Key? key}) : super(key: key);
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _avatar(user?.avatarUrl ?? ''),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(user?.name ?? '',
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Text(user?.company ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 16, fontFamily: 'Roboto')),
              Text(user?.location ?? '',
                  style: const TextStyle(fontSize: 16, fontFamily: 'Roboto')),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text((user?.projects?.length).toString(),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold)),
              const Text('Proyek', style: TextStyle(fontSize: 24)),
            ],
          ),
        )
      ],
    );
  }

  Widget _avatar(String? avatarUrl) {
    if (avatarUrl == null) {
      return Container(
        child: const Icon(Icons.person),
        height: 96,
        width: 96,
        color: Colors.grey,
      );
    }
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child:
            Image.network(avatarUrl, width: 96, height: 96, fit: BoxFit.cover));
  }
}

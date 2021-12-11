import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/auth/model/user.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(this.user, {Key? key}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _avatar(context),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profileName(context),
                    const SizedBox(height: 10),
                    _companyName(context),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text _companyName(BuildContext context) {
    return Text(user.company ?? '',
        style: const TextStyle(fontSize: 18, fontFamily: 'Roboto'));
  }

  Text _profileName(BuildContext context) {
    return Text(user.name ?? '',
        style: const TextStyle(
            fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w900));
  }

  Widget _avatar(BuildContext context) {
    final avatarUrl = user.avatarUrl;
    if (avatarUrl == null) {
      return Container(
        color: Colors.grey,
        height: 78,
        width: 78,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        width: 78,
        height: 78,
        fit: BoxFit.cover,
        placeholder: (_, __) => const PhotoPlaceHolder(),
      ),
    );
  }
}

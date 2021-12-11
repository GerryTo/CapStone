import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/profile/viewmodel/profile_viewmodel.dart';
import 'package:capstone/modules/profile/widgets/contact_button.dart';
import 'package:capstone/modules/profile/widgets/edit_profile_button.dart';

import 'package:capstone/modules/profile/widgets/feed_grid_item.dart';
import 'package:capstone/modules/profile/widgets/profile_empty_feed.dart';
import 'package:capstone/modules/profile/widgets/profile_feed_grid.dart';
import 'package:capstone/modules/profile/widgets/share_button.dart';
import 'package:capstone/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(this.userRef, {Key? key}) : super(key: key);
  final DocumentReference userRef;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(userRef),
      child: Consumer<ProfileViewModel>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile ',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900, fontSize: 20)),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _profileDetail(context),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _profileButtons(context),
                    width: double.infinity,
                  ),
                  _feeds(context),
                ],
              ),
            ),
            floatingActionButton: _myAddAction(value.userRef),
          );
        },
      ),
    );
  }

  Widget _myAddAction(DocumentReference userRef) {
    return Consumer<CurrentUserInfo>(builder: (context, user, _) {
      if (user.id != userRef.id) {
        return Container();
      }
      return FloatingActionButton(
          onPressed: () => Routes.router.navigateTo(context, Routes.addProject),
          child: const Icon(Icons.add));
    });
  }

  Widget _profileButtons(BuildContext context) {
    final currentUserId = context.read<CurrentUserInfo>().id;
    final profileId = userRef.id;
    if (currentUserId != profileId) {
      return Row(
        children: const [
          ContactButton(),
          SizedBox(width: 16),
          ShareProfileButton(),
        ],
      );
    } else {
      return Row(
        children: const [
          EditProfileButton(),
          SizedBox(width: 16),
          ShareProfileButton(),
        ],
      );
    }
  }

  Widget _profileDetail(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _avatar(context),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(context.watch<ProfileViewModel>().user?.name ?? '',
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Text(context.watch<ProfileViewModel>().user?.company ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 16, fontFamily: 'Roboto')),
              Text(context.watch<ProfileViewModel>().user?.location ?? '',
                  style: const TextStyle(fontSize: 16, fontFamily: 'Roboto')),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                  (context.watch<ProfileViewModel>().user?.projects?.length)
                      .toString(),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold)),
              const Text('Proyek', style: TextStyle(fontSize: 24)),
            ],
          ),
        )
      ],
    );
  }

  Widget _avatar(BuildContext context) {
    final avatarUrl = context.watch<ProfileViewModel>().user?.avatarUrl;
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

  Widget _feeds(BuildContext context) {
    final projects = context.watch<ProfileViewModel>().user?.projects;
    if (projects != null && projects.isNotEmpty) {
      return ProfileFeedGrid(projects);
    }
    return const ProfileEmptyFeed();
  }
}

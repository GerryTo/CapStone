import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/modules/profile/viewmodel/profile_viewmodel.dart';
import 'package:capstone/modules/profile/widgets/contact_button.dart';
import 'package:capstone/modules/profile/widgets/edit_profile_button.dart';
import 'package:capstone/modules/profile/widgets/profile_detail_widget.dart';
import 'package:capstone/modules/profile/widgets/profile_empty_feed.dart';
import 'package:capstone/modules/profile/widgets/profile_feed_grid.dart';
import 'package:capstone/modules/profile/widgets/share_button.dart';
import 'package:capstone/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.userRef == null) {
          return const NotFoundPage();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile ',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ProfileDetailWidget(viewModel.user),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _profileButtons(context, viewModel),
                  width: double.infinity,
                ),
                _feeds(viewModel.user?.projects),
              ],
            ),
          ),
          floatingActionButton: _myAddAction(context, viewModel.userRef),
        );
      },
    );
  }

  Widget? _myAddAction(
    BuildContext context,
    DocumentReference? userRef,
  ) {
    final currentUserId = Provider.of<CurrentUserInfo>(context).id;
    if (userRef == null) return null;
    if (currentUserId != userRef.id) {
      return null;
    }
    return FloatingActionButton(
      onPressed: () => Routes.router.navigateTo(context, Routes.addProject),
      child: const Icon(Icons.add),
    );
  }

  Widget _profileButtons(BuildContext context, ProfileViewModel viewModel) {
    final currentUserId = context.read<CurrentUserInfo>().id;
    final profileId = viewModel.userRef?.id;
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

  Widget _feeds(List<DocumentReference<Object?>>? projects) {
    if (projects != null && projects.isNotEmpty) {
      return ProfileFeedGrid(projects);
    }
    return const ProfileEmptyFeed();
  }
}

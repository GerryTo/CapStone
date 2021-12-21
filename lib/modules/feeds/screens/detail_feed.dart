import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/comment/widget/comment_widget.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/widgets/profile_widget.dart';
import 'package:capstone/modules/feeds/widgets/single_photo_widget.dart';
import 'package:capstone/modules/feeds/widgets/slider_photo_widget.dart';
import 'package:capstone/modules/feeds/viewmodel/detail_feed_viewmodel.dart';
import 'package:capstone/modules/feeds/widgets/favorite_button.dart';
import 'package:capstone/modules/feeds/widgets/my_feed_actions.dart';
import 'package:capstone/routes/routes.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailFeedsPage extends StatelessWidget {
  DetailFeedsPage(this.projectRef, {Key? key}) : super(key: key);
  final DocumentReference projectRef;

  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailFeedViewModel(
        projectRef,
        context.read<CurrentUserInfo>().userRef,
      ),
      child: Consumer<DetailFeedViewModel>(
        builder: (context, viewModel, child) {
          return _content(context, viewModel);
        },
      ),
    );
  }

  Scaffold _content(BuildContext context, DetailFeedViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail projek',
            style: GoogleFonts.roboto(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Routes.router.navigateTo(
                context,
                Routes.profileUser,
                routeSettings: RouteSettings(
                  arguments: viewModel.project?.userReference,
                ),
              ),
              child: _profile(viewModel),
            ),
            _photo(viewModel.project?.images ?? []),
            _title(viewModel.project),
            // Divider(height: 30,
            //   color: Colors.black,
            // ),
            _price(context, viewModel.project),
            _location(viewModel.project),
            _landArea(viewModel.project),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Text(
            //     'Deskripsi',
            //     style: Theme.of(context).textTheme.bodyText1,
            //   ),
            // ),
            _description(viewModel.project, context),
            _myFeedActions(viewModel.project),
            _comments(context, projectRef)
          ],
        ),
      ),
      floatingActionButton: _myFavoriteBottons(viewModel.project),
    );
  }

  Widget _profile(DetailFeedViewModel viewModel) {
    final user = viewModel.user;
    if (user == null) return Container();
    return ProfileWidget(user);
  }

  Widget _comments(BuildContext context, DocumentReference? projectRef) {
    if (projectRef == null) return Container();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: CommentWidget(projectRef),
    );
  }

  Widget _description(Feed? project, BuildContext context) {
    final String? description = project?.description;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Deskripsi',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text('$description', style: GoogleFonts.quicksand(fontSize: 16)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _title(Feed? project) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        project?.title ?? '',
        style: const TextStyle(
            fontSize: 24, fontFamily: 'ReadexPro', fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _location(Feed? project) {
    final String? location = project?.location;
    if (location == null || location.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              project?.location ?? '',
              style: const TextStyle(fontSize: 16, fontFamily: 'ReadexPro'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _price(BuildContext context, Feed? project) {
    final price = project?.price;
    if (price == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.attach_money,
            size: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              formatCurrency.format(price),
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _myFavoriteBottons(Feed? project) {
    return Consumer<CurrentUserInfo>(builder: (context, user, _) {
      if (user.id == null || user.id == project?.userReference?.id) {
        return Container();
      }
      return const FavoriteButton();
    });
  }

  Widget _myFeedActions(Feed? project) {
    return Consumer<CurrentUserInfo>(builder: (context, user, _) {
      if (user.id != project?.userReference?.id) {
        return Container();
      }
      return MyFeedAction(
        projectRef,
        onPressed: () {
          Routes.router
              .navigateTo(
            context,
            Routes.editFeed,
            routeSettings: RouteSettings(arguments: projectRef),
          )
              .then((_) {
            context.read<DetailFeedViewModel>().getFeedData();
          });
        },
      );
    });
  }

  Widget _photo(List<String> photos) {
    if (photos.length > 1) {
      return SliderPhotoWidget(photos);
    } else if (photos.length == 1) {
      return SinglePhotoWidget(photo: photos.first);
    } else {
      return const SinglePhotoWidget();
    }
  }

  Widget _landArea(Feed? project) {
    return project?.landArea != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                'Luas Tanah:\t${project?.landArea} m²',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          )
        : Container();
  }
}

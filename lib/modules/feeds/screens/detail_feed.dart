import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/comment/widget/comment_widget.dart';
import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/widgets/profile_widget.dart';
import 'package:capstone/modules/feeds/widgets/single_photo_widget.dart';
import 'package:capstone/modules/feeds/widgets/slider_photo_widget.dart';
import 'package:capstone/modules/feeds/viewmodel/detail_feed_viewmodel.dart';
import 'package:capstone/modules/feeds/widgets/favorite_button.dart';
import 'package:capstone/modules/feeds/widgets/my_feed_actions.dart';

import 'package:capstone/widget/loading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailFeedsPage extends StatefulWidget {
  const DetailFeedsPage(this.projectRef, {Key? key}) : super(key: key);
  final DocumentReference projectRef;
  @override
  State<DetailFeedsPage> createState() => _DetailFeedsPageState();
}

class _DetailFeedsPageState extends State<DetailFeedsPage> {
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.projectRef.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.data() as Map<String, dynamic>?;
          //apabila data tidak ditemukan tampilkan not found
          if (data == null) return const NotFoundPage();
          //parse map menjadi object Feed
          final project = Feed.fromMap(data);
          return ChangeNotifierProvider(
            create: (_) => DetailFeedViewModel(
              widget.projectRef,
              context.read<CurrentUserInfo>().userRef!,
            ),
            child: Consumer<DetailFeedViewModel>(
              builder: (context, viewModel, child) {
                return _content(context, project, viewModel);
              },
            ),
          );
        }

        if (snapshot.hasError) {
          return const NotFoundPage();
        }
        return const LoadingScreen();
      },
    );
  }

  Scaffold _content(
      BuildContext context, Feed project, DetailFeedViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title ?? "Proyek",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profile(viewModel),
              _photo(project.images ?? []),
              _title(project),
              _price(project),
              _description(project),
              _myFeedActions(project),
              _comments(widget.projectRef)
            ],
          ),
        ),
      ),
      floatingActionButton: _myFavoriteBottons(project),
    );
  }

  Widget _profile(DetailFeedViewModel viewModel) {
    final user = viewModel.user;
    if (user == null) return Container();
    return ProfileWidget(user);
  }

  Widget _comments(DocumentReference? projectRef) {
    if (projectRef == null) return Container();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: CommentWidget(projectRef),
    );
  }

  Widget _description(Feed project) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20),
      child: Text(project.description ?? '',
          style: GoogleFonts.poppins(fontSize: 14)),
    );
  }

  Widget _title(Feed project) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        project.title ?? '',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _price(Feed project) {
    final price = project.price;
    if (price == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        formatCurrency.format(price),
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _myFavoriteBottons(Feed project) {
    return Consumer<CurrentUserInfo>(builder: (context, user, _) {
      if (user.id == project.userReference?.id) {
        return Container();
      }
      return const FavoriteButton();
    });
  }

  Widget _myFeedActions(Feed project) {
    return Consumer<CurrentUserInfo>(builder: (context, user, _) {
      if (user.id != project.userReference?.id) {
        return Container();
      }
      return MyFeedAction(widget.projectRef);
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
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/viewmodel/detail_feed_viewmodel.dart';
import 'package:capstone/modules/feeds/widgets/favorite_button.dart';
import 'package:capstone/modules/feeds/widgets/my_feed_actions.dart';
import 'package:capstone/modules/feeds/widgets/photo_place_holder.dart';
import 'package:capstone/widget/card_photo.dart';
import 'package:capstone/widget/loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  int _currentIndex = 0;
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.projectRef.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.data();
          final project = Feed.fromMap(data as Map<String, dynamic>);
          return ChangeNotifierProvider(
              create: (_) => DetailFeedViewModel(
                    widget.projectRef,
                    context.read<CurrentUserInfo>().userRef!,
                  ),
              child: Consumer<DetailFeedViewModel>(
                builder: (context, value, child) {
                  return _content(context, project);
                },
              ));
        }

        if (snapshot.hasError) {
          return const NotFoundPage();
        }
        return const LoadingScreen();
      },
    );
  }

  Scaffold _content(BuildContext context, Feed project) {
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
              _profileWidget(context),
              if ((project.images?.length ?? 0) > 1)
                _sliderPhotos(project.images ?? [])
              else
                _onlyOnePhoto(context, project.images?.first),
              _title(project),
              _price(project),
              _description(project),
              _myFeedActions(project),
            ],
          ),
        ),
      ),
      floatingActionButton: _myFavoriteBottons(project),
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
      return FavoriteButton();
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

  Widget _onlyOnePhoto(BuildContext context, String? photo) {
    if (photo == null) {
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: photo,
      placeholder: (context, url) => Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Center _sliderPhotos(List<String> photos) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _carousel(photos),
          _carouselIndicator(photos),
        ],
      ),
    );
  }

  Padding _profileWidget(BuildContext context) {
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
    return Text(context.watch<DetailFeedViewModel>().user?.company ?? '',
        style: const TextStyle(fontSize: 18, fontFamily: 'Roboto'));
  }

  Text _profileName(BuildContext context) {
    return Text(context.watch<DetailFeedViewModel>().user?.name ?? '',
        style: const TextStyle(
            fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w900));
  }

  Widget _avatar(BuildContext context) {
    final avatarUrl = context.watch<DetailFeedViewModel>().user?.avatarUrl;
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

  Row _carouselIndicator(List<String> photos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: map<Widget>(
        photos,
        (index, url) {
          return Container(
            width: _currentIndex == index ? 15 : 10.0,
            height: 10.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: _currentIndex == index
                  ? Colors.grey
                  : Colors.grey.withOpacity(0.3),
            ),
          );
        },
      ),
    );
  }

  Stack _carousel(List<String> photos) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black,
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
              enableInfiniteScroll: false,
              aspectRatio: 1,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              }),
          items: photos.map((photo) {
            return CardPhoto(photo);
          }).toList(),
        ),
      ],
    );
  }
}

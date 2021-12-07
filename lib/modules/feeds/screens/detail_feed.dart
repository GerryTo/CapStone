import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/error/screens/not_found_page.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/feeds/viewmodel/detail_feed_viewmodel.dart';
import 'package:capstone/modules/feeds/widgets/favorite_button.dart';
import 'package:capstone/modules/feeds/widgets/my_feed_actions.dart';
import 'package:capstone/widget/card_photo.dart';
import 'package:capstone/widget/loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailFeedsPage extends StatefulWidget {
  const DetailFeedsPage(this.projectRef, {Key? key}) : super(key: key);
  final DocumentReference projectRef;
  @override
  State<DetailFeedsPage> createState() => _DetailFeedsPageState();
}

class _DetailFeedsPageState extends State<DetailFeedsPage> {
  int _currentIndex = 0;

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
            child: _content(context, project),
          );
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
        title: Text("Unggahan",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileWidget(),
              if ((project.images?.length ?? 0) > 1)
                _sliderPhotos(project.images ?? [])
              else
                _onlyOnePhoto(context, project.images?.first),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Text(project.title ?? '',
                    style: const TextStyle(fontSize: 24)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(project.description ?? '',
                    style: GoogleFonts.poppins(fontSize: 14)),
              ),
              _myFeedActions(project),
            ],
          ),
        ),
      ),
      floatingActionButton: _myFavoriteBottons(project),
    );
  }

  Widget _myFavoriteBottons(Feed project){
    return Consumer<CurrentUserInfo>(builder: (context,user,_){
      if(user.id == project.userReference?.id){
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

  Container _onlyOnePhoto(BuildContext context, String? photo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 450,
      decoration: BoxDecoration(
        image: DecorationImage(
            image:
                NetworkImage(photo ?? 'https://dummyimage.com/500x300/000/fff'),
            fit: BoxFit.fill),
      ),
    );
  }

  Center _sliderPhotos(List<String> photos) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: false,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              photos,
              (index, url) {
                return Container(
                  width: _currentIndex == index ? 15 : 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _currentIndex == index
                        ? Colors.grey
                        : Colors.grey.withOpacity(0.3),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _profileWidget() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('https://dummyimage.com/78x78/000/fff'),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Arsitek A",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900)),
                    SizedBox(height: 10),
                    Text('Perusahaan A',
                        style: TextStyle(fontSize: 18, fontFamily: 'Roboto')),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

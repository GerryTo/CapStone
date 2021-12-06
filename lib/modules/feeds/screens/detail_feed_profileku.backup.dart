import 'package:capstone/routes/routes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailFeedProfileKu extends StatefulWidget {
  const DetailFeedProfileKu(this.project, {Key? key}) : super(key: key);
  final DocumentReference project;
  @override
  State<DetailFeedProfileKu> createState() => _DetailFeedProfileKuState();
}

class _DetailFeedProfileKuState extends State<DetailFeedProfileKu> {
  int _currentIndex = 0;
  List<int> cardList = [];

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
      future: widget.project.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.data() as Map<String, dynamic>?;
          return Scaffold(
            appBar: AppBar(
              title: Text('SDFDF',
                  style: GoogleFonts.roboto(fontWeight: FontWeight.w900)),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((data?['images'] as List).length > 1)
                      _sliderPhotos(context, (data?['images'] as List))
                    else
                      _onlyOnePhoto(context, (data?['images'] as List?)?.first),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20),
                      child:
                          Text(data?['title'], style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Text(data?['description'],
                          style: const TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return const Placeholder();
        }
        return const Placeholder();
      },
    );
  }

  Container _onlyOnePhoto(BuildContext context, String images) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 450,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(images), fit: BoxFit.fill),
      ),
    );
  }

  Center _sliderPhotos(BuildContext context, List images) {
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
            items: images.map((item) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(item), fit: BoxFit.fill),
                ),
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              images,
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
}

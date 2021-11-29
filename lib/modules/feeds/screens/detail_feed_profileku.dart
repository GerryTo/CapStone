import 'package:capstone/routes/routes.dart';
import 'package:capstone/widget/card_photo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailFeedProfileKu extends StatefulWidget {
  @override
  State<DetailFeedProfileKu> createState() => _DetailFeedProfileKuState();
}

class _DetailFeedProfileKuState extends State<DetailFeedProfileKu> {
  int _currentIndex = 0;
  List<int> cardList = [1, 1];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arsitek A",
            style: GoogleFonts.roboto(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cardList.length > 1)
                _sliderPhotos()
              else
                _onlyOnePhoto(context),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Text('Judul Projek', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child:
                    Text('Deskripsi Projek A', style: TextStyle(fontSize: 14)),
              ),
              const SizedBox(height: 10),
              _buttons(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _onlyOnePhoto(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 450,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage('https://dummyimage.com/500x300/000/fff'),
            fit: BoxFit.fill),
      ),
    );
  }

  Center _sliderPhotos() {
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
            items: cardList.map((item) {
              return CardPhoto();
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              cardList,
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

  Padding _buttons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Wrap(children: const [
                Text(
                  'Hapus',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 19.0,
                )
              ]),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xffF23535), elevation: 0),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            // width: MediaQuery.of(context).size.width - 230,
            child: ElevatedButton(
              onPressed: () =>
                  Routes.router.navigateTo(context, Routes.editFeed),
              child: Wrap(
                children: [
                  Text('Edit',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.edit,
                    color: Theme.of(context).iconTheme.color,
                    size: 20.0,
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                      color: Theme.of(context).textTheme.button?.color ??
                          Colors.grey),
                  primary: Colors.transparent,
                  elevation: 0),
            ),
          ),
        ],
      ),
    );
  }

}

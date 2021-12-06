import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/widget/card_photo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EditFeedPage extends StatefulWidget {
  @override
  State<EditFeedPage> createState() => _EditFeedPageState();
}

class _EditFeedPageState extends State<EditFeedPage> {
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
        title: const Text('Edit unggahan'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
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
              _projectTitleField(),
              _projectDescriptionField(),
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
          // CarouselSlider(
          //   options: CarouselOptions(
          //       enableInfiniteScroll: false,
          //       viewportFraction: 1,
          //       onPageChanged: (index, reason) {
          //         setState(() {
          //           _currentIndex = index;
          //         });
          //       }),
          //   items: cardList.map((item) {
          //     return CardPhoto();
          //   }).toList(),
          // ),
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

  Widget _projectTitleField() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(label: Text('Judul Proyek')),
      ),
    );
  }

  Widget _projectDescriptionField() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        minLines: 3,
        maxLines: 5,
        decoration:
            InputDecoration(label: Text('Deskripsi'), alignLabelWithHint: true),
      ),
    );
  }
}

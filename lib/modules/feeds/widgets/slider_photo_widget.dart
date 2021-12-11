import 'package:capstone/widget/card_photo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderPhotoWidget extends StatefulWidget {
  const SliderPhotoWidget(this.photos, {Key? key}) : super(key: key);
  final List<String> photos;

  @override
  State<SliderPhotoWidget> createState() => _SliderPhotoWidgetState();
}

class _SliderPhotoWidgetState extends State<SliderPhotoWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _carousel(widget.photos),
        _carouselIndicator(widget.photos),
      ],
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

  Row _carouselIndicator(List<String> photos) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        photos.length,
        (index) => Container(
          width: _currentIndex == index ? 15 : 10.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _currentIndex == index
                ? Colors.grey
                : Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

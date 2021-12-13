import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFeedCarousel extends StatelessWidget {
  const AddFeedCarousel(
    this.files, {
    required this.onPageChange,
    required this.onRemove,
    Key? key,
  }) : super(key: key);
  final List<XFile> files;
  final Function(int, CarouselPageChangedReason) onPageChange;
  final Function() onRemove;

  @override
  Widget build(BuildContext context) {
    if (files.isNotEmpty) {
      return CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 1,
          pauseAutoPlayOnTouch: true,
          onPageChanged: onPageChange,
        ),
        items: files.map((file) {
          return Stack(
            children: [
              Image.file(
                File(file.path),
                fit: BoxFit.cover,
              ),
              _removeButton(),
            ],
          );
        }).toList(),
      );
    } else {
      return const Align(
        alignment: Alignment.center,
        child: Icon(
          Icons.photo,
          color: Colors.grey,
          size: 230,
        ),
      );
    }
  }

  Widget _removeButton() {
    return Positioned(
      right: 0,
      top: 0,
      child: IconButton(
        onPressed: onRemove,
        // onPressed: () {
        //   setState(() {
        //     _files.removeAt(_carouselIndex);
        //   });
        // },
        icon: const Icon(Icons.remove_circle_sharp),
        color: Colors.red,
      ),
    );
  }
}

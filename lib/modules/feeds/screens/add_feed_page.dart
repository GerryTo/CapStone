import 'dart:io';

import 'package:capstone/modules/feeds/viewmodel/add_feed_page_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddFeedPage extends StatefulWidget {
  const AddFeedPage({Key? key}) : super(key: key);

  @override
  State<AddFeedPage> createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  final ImagePicker _picker = ImagePicker();

  final List<XFile> _files = [];
  // ignore: unused_field
  int _carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddFeedPageViewModel(),
      builder: (context, _) {
        return _content(context);
      },
    );
  }

  Scaffold _content(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Tambah Proyek'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AddFeedPageViewModel>().send();
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.maxFinite,
                height: 250,
                color: Colors.grey.shade300,
                child: _images(),
              ),
              _buttonAddPhotos(context),
            ],
          ),
          _projectTitleField(),
          _projectDescriptionField(),
        ],
      ),
    );
  }

  Widget _buttonAddPhotos(BuildContext context) {
    return Positioned(
      bottom: 8,
      right: 0,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
        ),
        onPressed: () async {
          final files = await _picker.pickMultiImage() ?? [];
          setState(() {
            _files.addAll(files);
          });
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _images() {
    if (_files.isNotEmpty) {
      return CarouselSlider(
        options: CarouselOptions(
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            _carouselIndex = index;
          },
        ),
        items: _files.map((file) {
          return Stack(
            children: [
              Image.file(File(file.path)),
              _removeButton(),
            ],
          );
        }).toList(),
      );
    } else {
      return const Icon(
        Icons.photo,
        color: Colors.grey,
        size: 64,
      );
    }
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

  Widget _removeButton() {
    return Positioned(
      right: 0,
      top: 0,
      child: IconButton(
        onPressed: () {
          setState(() {
            _files.removeAt(_carouselIndex);
          });
        },
        icon: const Icon(Icons.remove_circle),
        color: Colors.grey.withAlpha(200),
      ),
    );
  }
}

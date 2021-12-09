import 'dart:developer';
import 'dart:io';

import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/feeds/viewmodel/add_feed_page_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
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
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  bool success = false;

  final List<XFile> _files = [];
  // ignore: unused_field
  int _carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CurrentUserInfo, AddFeedPageViewModel>(
      create: (context) =>
          AddFeedPageViewModel(context.read<CurrentUserInfo>()),
      builder: (context, _) {
        return _content(context);
      },
      update: (BuildContext context, currentUserInfo,
          AddFeedPageViewModel? previous) {
        return AddFeedPageViewModel(currentUserInfo);
      },
    );
  }

  Scaffold _content(BuildContext context) {
    context.watch<AddFeedPageViewModel>().addListener(() {
      final status = context.read<AddFeedPageViewModel>().status;
      if (status == AddFeedStatus.fail) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Gagal mengupload')));
      } else if (status == AddFeedStatus.success) {
        Routes.router.navigateTo(context, Routes.home, clearStack: true);
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah Proyek'),
        centerTitle: true,
        bottom: _loadingBar(context),
        actions: [
          IconButton(
            onPressed: () => _send(context),
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    width: double.maxFinite,
                    color: Colors.black,
                  ),
                ),
                _images(),
                _buttonAddPhotos(context),
              ],
            ),
            _projectTitleField(),
            _priceField(),
            _projectDescriptionField(),
          ],
        ),
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
          enableInfiniteScroll: false,
          viewportFraction: 1,
          pauseAutoPlayOnTouch: true,
          onPageChanged: (index, reason) {
            _carouselIndex = index;
          },
        ),
        items: _files.map((file) {
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
      return const Icon(
        Icons.photo,
        color: Colors.grey,
        size: 128,
      );
    }
  }

  Widget _projectTitleField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _titleController,
        decoration: const InputDecoration(
          label: Text('Judul Proyek'),
        ),
      ),
    );
  }

  Widget _projectDescriptionField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _descController,
        minLines: 3,
        maxLines: 5,
        decoration: const InputDecoration(
            label: Text('Deskripsi'), alignLabelWithHint: true),
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
        icon: const Icon(Icons.remove_circle_sharp),
        color: Colors.red,
      ),
    );
  }

  PreferredSize? _loadingBar(BuildContext context) {
    final status = context.watch<AddFeedPageViewModel>().status;
    if (status == AddFeedStatus.loading) {
      return const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator());
    }
  }

  void _send(BuildContext context) {
    final title = _titleController.text;
    final description = _descController.text;
    final price = int.tryParse(_priceController.text);

    if (title.isNotEmpty && description.isNotEmpty && _files.isNotEmpty) {
      context.read<AddFeedPageViewModel>().send(
          title: _titleController.text,
          description: _descController.text,
          price: price,
          files: _files);
    } else {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          backgroundColor: Theme.of(context).backgroundColor,
          content:
              const Text('Apakah anda sudah mengisi semua field dengan benar?'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
              },
              child: const Text('Dismiss'),
            )
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  Widget _priceField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: _priceController,
        decoration: const InputDecoration(
            label: Text('Harga'), alignLabelWithHint: true),
      ),
    );
  }
}

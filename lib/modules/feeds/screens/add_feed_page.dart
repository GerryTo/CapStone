import 'dart:io';

import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/feeds/viewmodel/add_feed_page_viewmodel.dart';
import 'package:capstone/modules/feeds/widgets/add_feed_slider.dart';
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

  int _carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddFeedPageViewModel>(
      create: (context) =>
          AddFeedPageViewModel(context.read<CurrentUserInfo>()),
      builder: (context, _) {
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
                Builder(builder: (context) {
                  context.watch<AddFeedPageViewModel>().addListener(
                    () {
                      final status =
                          context.read<AddFeedPageViewModel>().status;
                      if (status == AddFeedStatus.fail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Gagal mengupload')));
                      } else if (status == AddFeedStatus.success) {
                        Routes.router
                            .navigateTo(context, Routes.home, clearStack: true);
                      }
                    },
                  );
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          width: double.maxFinite,
                          color: Colors.black,
                        ),
                      ),
                      AddFeedCarousel(
                        _files,
                        onPageChange: (index, _) => _carouselIndex = index,
                        onRemove: () {
                          setState(() {
                            _files.removeAt(_carouselIndex);
                          });
                        },
                      ),
                      _buttonAddPhotos(context),
                    ],
                  );
                }),
                _projectTitleField(),
                _priceField(),
                _projectDescriptionField(),
              ],
            ),
          ),
        );
      },
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
        minLines: 1,
        maxLines: 5,
        decoration: const InputDecoration(
            label: Text('Deskripsi'), alignLabelWithHint: true),
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
          content: Text('Apakah anda sudah mengisi semua field dengan benar?',
              style: Theme.of(context).textTheme.subtitle2),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
              },
              child: const Text('Kembali'),
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

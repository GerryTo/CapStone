import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/feeds/viewmodel/edit_feed_profileku_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditFeedPage extends StatelessWidget {
  EditFeedPage(this.project, {Key? key}) : super(key: key);
  final DocumentReference project;

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditFeedProfileKuViewModel>(
      create: (_) => EditFeedProfileKuViewModel(
          ref: project.id, currentUserId: context.read<CurrentUserInfo>().id!),
      child: Consumer<EditFeedProfileKuViewModel>(
        builder: (context, value, child) {
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
                    _projectTitleField(context),
                    _projectDescriptionField(context),
                    _buttons(context, value.ref),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _projectTitleField(BuildContext context) {
    titleController.text =
        context.watch<EditFeedProfileKuViewModel>().feed?.title ?? '';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: titleController,
        decoration: const InputDecoration(label: Text('Judul projek')),
      ),
    );
  }

  Widget _projectDescriptionField(BuildContext context) {
    descController.text =
        context.watch<EditFeedProfileKuViewModel>().feed?.description ?? '';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: descController,
        minLines: 1,
        maxLines: 5,
        decoration: const InputDecoration(
            label: Text('Deskripsi'), alignLabelWithHint: true),
      ),
    );
  }

  Padding _buttons(BuildContext context, String ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (_) => _showDialogDelete(context),
                );
              },
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
                  primary: const Color(0xffF23535), elevation: 0),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (_) => _showDialog(
                      context, ref, titleController, descController),
                ).then((value) => Navigator.pop(context));
              },
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

  Widget _showDialog(BuildContext context, String ref,
      TextEditingController newTitle, TextEditingController newDesc) {
    return AlertDialog(
      title: const Text('Kamu yakin ?'),
      content: const Text('Kamu yakin untuk mengedit feednya?'),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Wrap(children: const [
                  Text(
                    'Tidak',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.cancel_sharp,
                    color: Colors.white,
                    size: 19.0,
                  )
                ]),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xffF23535), elevation: 0),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<EditFeedProfileKuViewModel>()
                      .editFeed(ref, newTitle.text, newDesc.text);
                  Routes.router.pop(context);
                },
                child: Wrap(
                  children: [
                    Text('Ya',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.check_sharp,
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
            ],
          ),
        )
      ],
    );
  }

  Widget _showDialogDelete(BuildContext context) {
    return AlertDialog(
      title: const Text('Kamu yakin ?'),
      content: const Text('Kamu yakin untuk menghapus feedn ini?'),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Routes.router.pop(context);
                },
                child: Wrap(children: const [
                  Text(
                    'Tidak',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.cancel_sharp,
                    color: Colors.white,
                    size: 19.0,
                  )
                ]),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xffF23535), elevation: 0),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<EditFeedProfileKuViewModel>()
                      .deleteFeed();
                  Routes.router.navigateTo(context, Routes.home, clearStack: true);
                },
                child: Wrap(
                  children: [
                    Text('Ya',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.check_sharp,
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
            ],
          ),
        )
      ],
    );
  }
}

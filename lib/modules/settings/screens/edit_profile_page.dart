import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/modules/settings/viewmodel/edit_profile_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileViewModel(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    _avatar(context),
                  ],
                ),
              ),
              _name(context),
              _company(context),
              _location(context),
            ],
          ),
        );
      }),
    );
  }

  ListTile _location(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.map),
      title: const Text('Lokasi'),
      trailing: const Icon(Icons.edit),
      onTap: () =>
          _showEditDialog(context, label: 'Masukan Lokasi', onSubmit: () {}),
    );
  }

  ListTile _company(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.work),
      title: const Text('Nama Perusahaan'),
      trailing: const Icon(Icons.edit),
      onTap: () => _showEditDialog(context,
          label: 'Masukan Nama Perusahaan', onSubmit: () {}),
    );
  }

  ListTile _name(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: const Text('Nama'),
      trailing: const Icon(Icons.edit),
      onTap: () =>
          _showEditDialog(context, label: 'Masukan Nama', onSubmit: () {}),
    );
  }

  Stack _avatar(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Image.network(
          context.read<EditProfileViewModel>().avatarUrl,
          width: 128,
          height: 128,
        ),
        Positioned(
          bottom: -8,
          right: -16,
          child: ElevatedButton(
            onPressed: () {},
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              primary: AppColors.primaryColor,
              onPrimary: Colors.red,
            ),
          ),
        )
      ],
    );
  }

  void _showEditDialog(BuildContext context,
      {required String label, required void Function() onSubmit}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(label: Text(label)),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Routes.router.pop(context),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: onSubmit,
                    child: const Text('Simpan'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

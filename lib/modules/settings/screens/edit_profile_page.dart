import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/constants/city_names.dart';
import 'package:capstone/modules/auth/provider/current_user_info.dart';
import 'package:capstone/modules/settings/viewmodel/edit_profile_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CurrentUserInfo, EditProfileViewModel>(
      create: (context) =>
          EditProfileViewModel(context.read<CurrentUserInfo>()),
      update: (BuildContext context, currentUserInfo,
          EditProfileViewModel? previous) {
        return EditProfileViewModel(currentUserInfo);
      },
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit profile',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    _avatarEdit(context),
                  ],
                ),
              ),
              _name(context),
              _company(context),
              _location(context),
              _phone(context),
            ],
          ),
        );
      }),
    );
  }

  ListTile _location(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.map, color: Theme.of(context).iconTheme.color),
      title: DropdownButton<String>(
        isExpanded: true,
        value: context.watch<EditProfileViewModel>().location,
        items: List.generate(
          citiesData.length,
          (index) => DropdownMenuItem(
            value: citiesData[index],
            child: Text(
              citiesData[index],
            ),
          ),
        ),
        onChanged: (location) {
          if (location != null) {
            context.read<EditProfileViewModel>().updateLocation(location);
          }
        },
      ),
    );
  }

  ListTile _company(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.work, color: Theme.of(context).iconTheme.color),
      title: Text(context.watch<EditProfileViewModel>().company),
      trailing: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
      onTap: () => _showEditDialog(
        context,
        label: 'Masukan Nama Perusahaan',
        onSubmit: () => context
            .read<EditProfileViewModel>()
            .updateCompany(companyController.text),
        controller: companyController,
      ),
    );
  }

  ListTile _name(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
      title: Text(context.watch<EditProfileViewModel>().name),
      trailing: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
      onTap: () => _showEditDialog(
        context,
        label: 'Masukan Nama',
        onSubmit: () {
          context.read<EditProfileViewModel>().updateName(nameController.text);
        },
        controller: nameController,
      ),
    );
  }

  Stack _avatarEdit(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        _avatar(context),
        Positioned(
          bottom: -8,
          right: -16,
          child: ElevatedButton(
            onPressed: () async {
              final image =
                  await _picker.pickImage(source: ImageSource.gallery);
              final path = image?.path;
              if (path != null) {
                context.read<EditProfileViewModel>().updateAvatar(File(path));
              }
            },
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

  Widget _avatar(BuildContext context) {
    final avatar = context.watch<EditProfileViewModel>().avatarUrl;
    if (avatar == null) {
      return Container(
        width: 128,
        height: 128,
        child: const Icon(Icons.person),
        color: Colors.grey,
      );
    }
    return CachedNetworkImage(
      imageUrl: avatar,
      width: 128,
      height: 128,
      fit: BoxFit.cover,
    );
  }

  void _showEditDialog(
    BuildContext context, {
    required String label,
    required void Function() onSubmit,
    required TextEditingController controller,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: controller,
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
                    onPressed: () async {
                      onSubmit();
                      Routes.router.pop(context);
                    },
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

  Widget _phone(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.phone, color: Theme.of(context).iconTheme.color),
      trailing: Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
      title: Text(context.watch<EditProfileViewModel>().phone),
      onTap: () {
        _showEditDialog(context, label: 'No. Telpon', onSubmit: () {
          context
              .read<EditProfileViewModel>()
              .updatePhone(phoneController.text);
        }, controller: phoneController);
      },
    );
  }
}

import 'package:capstone/config/themes/app_colors.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      'https://dummyimage.com/96x96/000/fff',
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
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Nama'),
            trailing: const Icon(Icons.edit),
            onTap: () => _showEditDialog(context,
                label: 'Masukan Nama', onSubmit: () {}),
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: const Text('Nama Perusahaan'),
            trailing: const Icon(Icons.edit),
            onTap: () => _showEditDialog(context,
                label: 'Masukan Nama Perusahaan', onSubmit: () {}),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Lokasi'),
            trailing: const Icon(Icons.edit),
            onTap: () => _showEditDialog(context,
                label: 'Masukan Lokasi', onSubmit: () {}),
          ),
        ],
      ),
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
                    onPressed: () {},
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

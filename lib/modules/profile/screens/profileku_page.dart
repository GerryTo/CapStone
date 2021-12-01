import 'package:capstone/modules/profile/viewmodel/show_user_profile.viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileKuPage extends StatefulWidget {
  const ProfileKuPage({Key? key}) : super(key: key);

  @override
  State<ProfileKuPage> createState() => _ProfileKuPageState();
}

class _ProfileKuPageState extends State<ProfileKuPage> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShowUserProfileViewModel(),
      builder:(context , _){
        return Scaffold(
          appBar: AppBar(
            title: Text(context.watch<ShowUserProfileViewModel>().user?.name ?? '',
                style: GoogleFonts.roboto(fontWeight: FontWeight.w900)),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _profileDetail(),
                ),
                _buttons(context),
                _feedGrid(context)
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Routes.router.navigateTo(context, Routes.addProject),
            child: const Icon(Icons.add),
          ),
        );
      }
    );
  }

  Padding _buttons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () =>
                  Routes.router.navigateTo(context, Routes.accountSettings),
              child: Wrap(
                children: [
                  Text('Edit Akun',
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

  Padding _feedGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 3,
          children: List.generate(12, (index) => _profileFeedCard(context))),
    );
  }

  Widget _profileDetail() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(context.watch<ShowUserProfileViewModel>().user?.avatarUrl ?? ''),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
            Text(context.watch<ShowUserProfileViewModel>().user?.name ?? '',
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            Text(context.watch<ShowUserProfileViewModel>().user?.company ?? '',
                style: const TextStyle(fontSize: 18, fontFamily: 'Roboto')),
            Text(context.watch<ShowUserProfileViewModel>().user?.location ?? '',
                style: const TextStyle(fontSize: 18, fontFamily: 'Roboto')),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Text((context.watch<ShowUserProfileViewModel>().user?.projects?.length).toString(),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const Text('Proyek', style: TextStyle(fontSize: 24)),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector _profileFeedCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Routes.router.navigateTo(context, Routes.detailFeedProfilKu),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[100],
      ),
    );
  }
}

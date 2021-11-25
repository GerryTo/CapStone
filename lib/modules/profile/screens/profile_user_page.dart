import 'package:capstone/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUserPage extends StatefulWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arsitek A",
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

  Padding _buttons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Wrap(children: const [
                Text(
                  'Kontak',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.contacts,
                  color: Colors.white,
                  size: 19.0,
                )
              ]),
              style:
                  ElevatedButton.styleFrom(primary: Colors.black, elevation: 0),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            // width: MediaQuery.of(context).size.width - 230,
            child: ElevatedButton(
              onPressed: () {},
              child: Wrap(
                children: [
                  Text('Bagikan',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.share,
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
        Image.network('https://dummyimage.com/96x96/000/fff'),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text("Arsitek A",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900)),
            SizedBox(height: 10),
            Text('Perusahaan A',
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto')),
            Text('Nama Kota',
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto')),
          ],
        ),
        Expanded(
          child: Column(
            children: const [
              Text('10',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text('Proyek', style: TextStyle(fontSize: 24)),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector _profileFeedCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Routes.router.navigateTo(context, Routes.detailFeed),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.teal[100],
      ),
    );
  }
}

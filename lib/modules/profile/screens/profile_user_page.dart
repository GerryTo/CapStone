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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network('https://dummyimage.com/78x78/000/fff'),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Arsitek A",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w900)),
                          SizedBox(height: 10),
                          Text('Perusahaan A',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Roboto')),
                          Text('Nama Kota',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Roboto')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width - 340,
                          top: 10),
                      child: Column(
                        children: [
                          Text('10',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                          Text('Projek', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      // width: MediaQuery.of(context).size.width - 230,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Wrap(children: [
                          const Text(
                            'Kontak',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.contacts,
                            color: Colors.white,
                            size: 19.0,
                          )
                        ]),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black, elevation: 0),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      // width: MediaQuery.of(context).size.width - 230,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Wrap(
                          children: [
                            const Text(
                              'Bagikan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.share,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            primary: Colors.transparent,
                            elevation: 0),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(5),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 3,
                children: <Widget>[
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Routes.router.navigateTo(context, Routes.detailFeed),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

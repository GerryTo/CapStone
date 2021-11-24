import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailFeedsPage extends StatefulWidget {
  @override
  State<DetailFeedsPage> createState() => _DetailFeedsPageState();
}

class _DetailFeedsPageState extends State<DetailFeedsPage> {
  late bool _isFavorited;
  @override
  void initState() {
    super.initState();
    _isFavorited = false;
  }
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        children: const [
                          Text("Arsitek A",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w900)),
                          SizedBox(height: 10),
                          Text('Perusahaan A',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Roboto')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        icon: Icon(
                            _isFavorited
                                ? Icons.favorite_rounded
                                : Icons.favorite_outline_rounded,
                            color: Colors.black),
                        onPressed: () {
                          setState(() {
                            _isFavorited = !_isFavorited;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                height: MediaQuery.of(context).size.height - 400,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://dummyimage.com/400x200/000/fff'),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 20),
                  child: Text('Judul Projek',style: TextStyle(fontSize: 18)),),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text('Deskripsi Projek A',style: TextStyle(fontSize: 14)),)
            ],
          ),
        ),
      ),
    );
  }
}

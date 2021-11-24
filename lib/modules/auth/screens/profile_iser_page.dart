import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class profileUserPage extends StatefulWidget {
  @override
  State<profileUserPage> createState() => _profileUserPageState();
}

class _profileUserPageState extends State<profileUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arsitek A"),
        centerTitle: true,
        backgroundColor: Color(0xff0B3D66),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network('https://dummyimage.com/78x78/000/fff'),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama A', style: TextStyle(fontSize: 18)),
                          SizedBox(height: 10),
                          Text('Perusahaan A', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width - 340, top: 10),
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
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 230,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Contact',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(color: Colors.black),
                            primary: Colors.transparent,
                            elevation: 0),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: MediaQuery.of(context).size.width - 230,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Share',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(color: Colors.black),
                            primary: Colors.transparent,
                            elevation: 0),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 4,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("He'd have you all unravel at the"),
                    color: Colors.teal[100],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Heed not the rabble'),
                    color: Colors.teal[200],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Sound of screams but the'),
                    color: Colors.teal[300],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Who scream'),
                    color: Colors.teal[400],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution is coming...'),
                    color: Colors.teal[500],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text('Revolution, they...'),
                    color: Colors.teal[600],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

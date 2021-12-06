import 'package:capstone/config/themes/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditFeedPage extends StatefulWidget {
  const EditFeedPage(this.project,   {Key? key}) : super(key: key);
  final DocumentReference project;
  @override
  State<EditFeedPage> createState() => _EditFeedPageState();
}

class _EditFeedPageState extends State<EditFeedPage> {
  int _currentIndex = 0;

  List<int> cardList = [1, 1];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: widget.project.get(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          final data = snapshot.data?.data() as Map<String , dynamic>?;
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
                    if (cardList.length > 1)
                      _sliderPhotos()
                    else
                      _onlyOnePhoto(context),
                    _projectTitleField(data?['title']),
                    _projectDescriptionField(data?['description']),
                  ],
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  Container _onlyOnePhoto(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 450,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage('https://dummyimage.com/500x300/000/fff'),
            fit: BoxFit.fill),
      ),
    );
  }

  Center _sliderPhotos() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                }),
            items: [],
            // items: cardList.map((item) {
            //   return CardPhoto();
            // }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              cardList,
              (index, url) {
                return Container(
                  width: _currentIndex == index ? 15 : 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: _currentIndex == index
                        ? Colors.grey
                        : Colors.grey.withOpacity(0.3),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _projectTitleField(String title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: TextEditingController(text: title),
        decoration: InputDecoration(label: Text('Judul projek')),
      ),
    );
  }

  Widget _projectDescriptionField(String desc) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: TextEditingController(text: desc),
        minLines: 3,
        maxLines: 5,
        decoration:
            InputDecoration(label: Text('Deskripsi'), alignLabelWithHint: true),
      ),
    );
  }
}

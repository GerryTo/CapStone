import 'package:capstone/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFeedAction extends StatelessWidget {
  MyFeedAction( this.project, {Key? key}) : super(key: key);
  DocumentReference project;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
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
            // width: MediaQuery.of(context).size.width - 230,
            child: ElevatedButton(
              onPressed: () =>
                  Routes.router.navigateTo(context, Routes.editFeed, routeSettings: RouteSettings(arguments:project)),
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
}

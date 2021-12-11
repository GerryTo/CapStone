import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.grey,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey,
                      width: double.infinity,
                      height: 24,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(height: 32, width: 32, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            color: Colors.grey,
                            // width: double.infinity,
                            height: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Spacer(),
                        Expanded(
                          child: Container(
                            color: Colors.grey,
                            // width: double.infinity,
                            height: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

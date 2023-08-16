import 'package:flutter/material.dart';

class ShowPostScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String text;
  final DateTime created;

  const ShowPostScreen({
    required this.title,
    required this.imageUrl,
    required this.text,
    required this.created,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title),
            Text(created.toIso8601String())
          ],
        ),
        Image.network(imageUrl),
        Text(text),
      ],
    );
  }
}

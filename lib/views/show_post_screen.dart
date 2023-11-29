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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Text(title),
              const SizedBox(width: 8),
              Text(created.toIso8601String())
            ],
          ),
          Image.network(imageUrl),
          const SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }
}

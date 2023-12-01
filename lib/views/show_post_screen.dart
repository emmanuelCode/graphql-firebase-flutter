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
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Text(created.toIso8601String(),
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Image.network(imageUrl),
            const SizedBox(height: 16),
            Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

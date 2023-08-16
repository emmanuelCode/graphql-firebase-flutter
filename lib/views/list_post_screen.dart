import 'package:flutter/material.dart';

class PostsList extends StatelessWidget {
  // need id here for deletion
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}

class PostCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final DateTime created;

  const PostCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.created});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Image.network(imageUrl),
        ),
        ListTile(
          title: Text(title),
          subtitle: Text(created.toIso8601String()),
        ),
      ],
    );
  }
}

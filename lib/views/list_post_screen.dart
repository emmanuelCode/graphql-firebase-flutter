import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';

class PostsList extends ConsumerWidget {
  // need id here for deletion
  const PostsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(authProvider.notifier).username;
    return WillPopScope(
        onWillPop: () async {
          Auth auth = ref.read(authProvider.notifier);
          await auth.logOut();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Hello $userName'),
          ),
          body: ListView(),
        ));
  }
}

class PostCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final DateTime created;

  const PostCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.created,
  });

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

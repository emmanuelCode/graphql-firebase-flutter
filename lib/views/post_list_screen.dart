import 'package:flutter/material.dart';
import 'package:flutter_firebase_graphql/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';

class PostsListScreen extends ConsumerWidget {
  // need id here for deletion
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(authProvider.notifier).username;
    final userPosts = ref.watch(userPostsProvider.notifier);
    
    return WillPopScope(
      onWillPop: () async {
        Auth auth = ref.read(authProvider.notifier);
        await auth.logOut();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('$userName\'s Posts'),
        ),
        body: ref.watch(userPostsProvider).when(
              data: (posts) => ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostCard(
                    title: posts[index].title,
                    imageUrl: posts[index].imageUrl,
                    created: posts[index].dateTime,
                  );
                },
              ),
              error: (e, s) => Text('Error: $e,$s'),
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await userPosts.createPost(),
        ),
      ),
    );
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
          child: Image.network('https://picsum.photos/id/237/200/300'),
        ),
        ListTile(
          title: Text(title),
          subtitle: Text(created.toIso8601String()),
          onTap: () {},
        ),
      ],
    );
  }
}

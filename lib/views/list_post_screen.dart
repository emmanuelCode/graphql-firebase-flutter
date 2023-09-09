import 'package:flutter/material.dart';
import 'package:flutter_firebase_graphql/models/post.dart';
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
          body: Column(
            children: [
              //todo fix
              // FutureBuilder(
              //     future: ref.watch(userPostsProvider.notifier).getPosts(),
              //     builder: (context, AsyncSnapshot<List<Post>> posts) {
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         itemBuilder: (BuildContext context, int index) {
              //           if (posts.hasData) {
              //             final post = posts.data![index];
              //             return PostCard(
              //               title: post.title,
              //               imageUrl: post.imageUrl,
              //               created: post.dateTime,
              //             );
              //           }
              //
              //           if (posts.hasError) {
              //             debugPrint('${posts.error}');
              //           }
              //
              //           return const CircularProgressIndicator.adaptive();
              //         },
              //       );
              //     }),
              OutlinedButton(
                  onPressed: () async {
                   // await userPosts.getPosts();
                  },
                  child: const Text('get Posts')),
              OutlinedButton(
                  onPressed: () async {
                    final userPosts = ref.read(userPostsProvider.notifier);

                    return await userPosts.createPost();
                  },
                  child: const Text('create Post')),
            ],
          ),
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
          onTap: () {},
        ),
      ],
    );
  }
}

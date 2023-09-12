import 'package:flutter/material.dart';
import 'package:flutter_firebase_graphql/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';
import 'show_post_screen.dart';

class PostsListScreen extends ConsumerWidget {
  // need id here for deletion
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(authProvider.notifier).username;
    final userPosts = ref.watch(userPostsProvider.notifier);

    final PageController controller = PageController();

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
              data: (posts) => posts.isEmpty
                  ? const Center(child: Text('No Posts'))
                  : PageView(
                      controller: controller,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return PostCard(
                              title: posts[index].title,
                              imageUrl: posts[index].imageUrl,
                              created: posts[index].dateTime,
                              onTap: () => controller.animateToPage(
                                // +1 since we have a list to first index
                                index + 1,
                                duration: const Duration(seconds: 1),
                                curve: Curves.linearToEaseOut,
                              ),
                            );
                          },
                        ),
                        for (var post in posts)
                          ShowPostScreen(
                            title: post.title,
                            text: post.text,
                            created: post.dateTime,
                            imageUrl: post.imageUrl,
                          )
                      ],
                    ),
              error: (e, s) => Text('Error: $e,$s'),
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await userPosts.createPost(),

          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) => AddPostSheet(
          //     createPost: userPosts.createPost,
          //   ),
          //   isScrollControlled: true,
          //   useSafeArea: true,
          // ),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final DateTime created;
  final VoidCallback onTap;

  const PostCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.created,
    required this.onTap,
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
          onTap: onTap,
        ),
      ],
    );
  }
}

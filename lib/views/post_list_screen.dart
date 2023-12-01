import 'package:flutter/material.dart';
import 'package:flutter_firebase_graphql/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';
import 'add_or_update_post_sheet.dart';
import 'show_post_screen.dart';

class PostsListScreen extends ConsumerWidget {
  // need id here for deletion
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider.notifier);
    final userName = auth.username;
    final userID = auth.id!;
    final graphqlClient = ref.watch(graphQLClientProvider(auth.token!));
    final userPosts =
        ref.watch(userPostsProvider(graphqlClient, userID).notifier);

    final PageController controller = PageController();

    return PopScope(
      onPopInvoked: (value) async {
        Auth auth = ref.read(authProvider.notifier);
        await auth.logOut();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('$userName\'s Posts'),
        ),
        body: ref.watch(userPostsProvider(graphqlClient, userID)).when(
              data: (posts) => posts.isEmpty
                  ? const Center(child: Text('No Posts'))
                  : PageView(
                      controller: controller,
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return PostCard(
                              post: posts[index],
                              onTap: () => controller.animateToPage(
                                // +1 since we have a list to first index
                                index + 1,
                                duration: const Duration(seconds: 1),
                                curve: Curves.linearToEaseOut,
                              ),
                              onDelete: () async => await userPosts.deletePost(
                                id: posts[index].id,
                              ),
                              updatePost: userPosts.updatePost,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => AddOrUpdatePostSheet(
              createPost: userPosts.createPost,
            ),
            isScrollControlled: true,
            useSafeArea: true,
          ),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final Future<void> Function({
    required String id,
    required String imageID,
    required String text,
    required String title,
  }) updatePost;

  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onDelete,
    required this.updatePost,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Image.network(post.imageUrl),
            ),
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.edit_note),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => AddOrUpdatePostSheet(
                    updatePost: updatePost,
                    currentPost: post,
                  ),
                  isScrollControlled: true,
                  useSafeArea: true,
                ),
              ),
              title: Text(post.title),
              subtitle: Text(post.dateTime.toIso8601String()),
              trailing: IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

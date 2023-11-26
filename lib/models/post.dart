import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// hide the JsonSerializable as there is a library conflict with json_annotation
import 'package:graphql/client.dart' hide JsonSerializable;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post.g.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String title,
    required String imageUrl,
    required String text,
    required DateTime dateTime,
  }) = _Post;
  factory Post.fromJson(Map<String, Object?> json) => _$PostFromJson(json);
}

@riverpod
class UserPosts extends _$UserPosts {
  @override
  Future<List<Post>> build(GraphQLClient client) async {
    return _getPosts();
  }

  // write queries methods (ADD, UPDATE, READ, DELETE) ...

  Future<void> createPost() async {
    // set the state to loading
    state = const AsyncValue.loading();

    final String addPostMutation =
        await rootBundle.loadString('lib/graphql_queries/add_post.graphql');

    final MutationOptions options = MutationOptions(
      document: gql(addPostMutation),
      variables: <String, dynamic>{
        // the variable put here must match the query variable ($user)
        'post': {
          'title': 'Jane Doe',
          'imageUrl': 'url',
          'text': 'related to John Doe',
          'dateTime': DateTime.now().toIso8601String(),
        }
      },
    );

    // get the graphql client to perform queries and mutation
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      debugPrint('${result.exception}');
    }
    debugPrint('ADDED: ${result.data}');

    final newPost = Post.fromJson(result.data!['addPost']['post'][0]);
    final oldState = state.value;

    state = AsyncValue.data([
      ...oldState!,
      newPost,
    ]);
  }

  Future<void> deletePost(String id) async {
    // set the state to loading
    state = const AsyncValue.loading();

    final String addPostMutation =
        await rootBundle.loadString('lib/graphql_queries/delete_post.graphql');

    final MutationOptions options = MutationOptions(
      document: gql(addPostMutation),
      variables: <String, dynamic>{
        // the variable put here must match the query variable ($filter)
        'filter': {
            'id': id,
        }
      },
    );

    // get the graphql client to perform queries and mutation
    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      debugPrint('${result.exception}');
    }
    debugPrint('DELETED: ${result.data}');

    final deletePost = Post.fromJson(result.data!['deletePost']['post'][0]);

    final oldPost = state.value!;
    // update list with removing the post that has the same id
    oldPost.removeWhere((post) => post.id == deletePost.id );

    state = AsyncValue.data(oldPost);
  }

  // get all posts entered
  Future<List<Post>> _getPosts() async {
    final String getPostsQuery = await rootBundle
        .loadString('lib/graphql_queries/get_list_posts.graphql');

    final QueryOptions options = QueryOptions(
      document: gql(getPostsQuery),
      variables: const <String, dynamic>{
        // the variable put here must match the query variable
      },
    );

    //get the graphql client to perform queries and mutation
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      debugPrint('${result.exception}');
    }

    debugPrint('${result.data}');

    final List<dynamic> queryArray = result.data!['queryPost'];

    List<Post> posts = queryArray.map((e) => Post.fromJson(e)).toList();

    debugPrint('ALL POSTS: $posts');

    return posts;
  }
}

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
  Future<List<Post>> build(GraphQLClient client, String userID) async {
    return _getPosts();
  }

  // TODO add arguments to queries so the user can enter them 

  Future<void> createPost() async {
    // set the state to loading
    state = const AsyncValue.loading();

    final String addPostMutation =
        await rootBundle.loadString('lib/graphql_queries/add_post.graphql');

    final MutationOptions options = MutationOptions(
      document: gql(addPostMutation),
      variables: <String, dynamic>{
        // the variable put here must match the query variable ($post)
        'post': {
          'title': 'Jane Doe',
          'imageUrl': 'https://picsum.photos/id/238/300/300',
          'text': 'related to John Doe',
          'dateTime': DateTime.now().toIso8601String(),
          'postOwnerID': userID,
        }
      },
    );

    // update the state when future finishes
    state = await AsyncValue.guard(() async {
      // get the graphql client to perform queries and mutation
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        debugPrint('${result.exception}');
      }
      debugPrint('ADDED: ${result.data}');

      return _getPosts();
    });
  }

   Future<void> updatePost(String id) async {
    // set the state to loading
    state = const AsyncValue.loading();

    final String updatePostMutation =
        await rootBundle.loadString('lib/graphql_queries/update_post.graphql');

    final MutationOptions options = MutationOptions(
      document: gql(updatePostMutation),
      variables: <String, dynamic>{
        // the variable put here must match the query variable ($patch)
        'patch': {
          'filter': {
            'id': [id],
          },
          'set': {
            'title': 'Jane Doe2',
            'imageUrl': 'https://picsum.photos/id/240/300/300',
            'text': 'related to John Doe2',
            'dateTime': DateTime.now().toIso8601String(),
            // here we don't need to update the ownwer so we omit postOwnerID
          }
        }
      },
    );

    // update the state when future finishes
    state = await AsyncValue.guard(() async {
      // get the graphql client to perform queries and mutation
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        debugPrint('${result.exception}');
      }
      debugPrint('UPDATE: ${result.data}');

      return _getPosts();
    });
  }

  Future<void> deletePost(String id) async {
    // set the state to loading
    state = const AsyncValue.loading();

    final String addPostMutation =
        await rootBundle.loadString('lib/graphql_queries/delete_post.graphql');

    final MutationOptions options = MutationOptions(
      fetchPolicy: FetchPolicy.noCache,
      document: gql(addPostMutation),
      variables: <String, dynamic>{
        // the variable put here must match the query variable ($filter)
        'filter': {
          'id': id,
        }
      },
    );

    // update the state when future finishes
    state = await AsyncValue.guard(() async {
      // get the graphql client to perform queries and mutation
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        debugPrint('${result.exception}');
      }
      debugPrint('DELETED: ${result.data}');

      return _getPosts();
    });
  }

  // get all posts entered
  Future<List<Post>> _getPosts() async {
    final String getPostsQuery = await rootBundle
        .loadString('lib/graphql_queries/get_list_posts.graphql');

    final QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.noCache,
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

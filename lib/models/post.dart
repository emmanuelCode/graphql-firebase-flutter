import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_graphql/models/auth.dart';
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

@Riverpod(keepAlive: true)
class UserPosts extends _$UserPosts {
  late GraphQLClient _client;

  @override
  Future<List<Post>> build() async {
    User? user = ref.watch(authProvider);

    final token = await user?.getIdToken();

    _client = ref.read(graphQLClientProvider(token!));

    return _getPosts();
  }

  // write queries methods (ADD, UPDATE, READ, DELETE) ...

  Future<void> createPost() async {
    //this works.. todo to refactor..
    User? user = ref.watch(authProvider);
    final token = await user?.getIdToken();
    debugPrint('TOKEN #2 $token');
    _client = ref.read(graphQLClientProvider(token!));


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

    state = await AsyncValue.guard(() async {
      //get the graphql client to perform queries and mutation
      final QueryResult result = await _client.mutate(options);

      if (result.hasException) {
        debugPrint('${result.exception}');
      }
      debugPrint('ADDED: ${result.data}');

      return _getPosts();
    });
  }

  // get all posts entered
  // this will be private as I need it to reload the list internally
  // inspired by : https://docs-v2.riverpod.dev/docs/providers/notifier_provider
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
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      debugPrint('${result.exception}');
    }

    debugPrint('${result.data}');

    final List<dynamic> queryArray = result.data?['queryPost'];

    List<Post> posts = queryArray.map((e) => Post.fromJson(e)).toList();

    debugPrint('ALL POSTS: $posts');

    return posts;
  }
}

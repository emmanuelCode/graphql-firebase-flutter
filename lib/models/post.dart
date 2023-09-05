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

@riverpod
class UserPosts extends _$UserPosts {
  late GraphQLClient _client;

  @override
  Post build() {
    String? token = ref.read(authProvider.notifier).token;
    debugPrint('TOKEN #2 $token');
    _client = ref.read(graphQLClientProvider(token!));

    return Post(
      id: '',
      text: '',
      imageUrl: '',
      title: '',
      dateTime: DateTime.now(),
    );
  }

  // write queries methods (ADD, UPDATE, READ, DELETE) ...

  Future<void> createPost() async {
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

    //get the graphql client to perform queries and mutation
    final QueryResult result = await _client.mutate(options);
    debugPrint('${result.data}');
    if (result.hasException) {
      debugPrint('${result.exception}');
    }
  }
}

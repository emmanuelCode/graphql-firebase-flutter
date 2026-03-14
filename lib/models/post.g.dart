// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: json['id'] as String,
  title: json['title'] as String,
  imageUrl: json['imageUrl'] as String,
  text: json['text'] as String,
  dateTime: DateTime.parse(json['dateTime'] as String),
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'imageUrl': instance.imageUrl,
  'text': instance.text,
  'dateTime': instance.dateTime.toIso8601String(),
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserPosts)
final userPostsProvider = UserPostsFamily._();

final class UserPostsProvider
    extends $AsyncNotifierProvider<UserPosts, List<Post>> {
  UserPostsProvider._({
    required UserPostsFamily super.from,
    required (GraphQLClient, String) super.argument,
  }) : super(
         retry: null,
         name: r'userPostsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userPostsHash();

  @override
  String toString() {
    return r'userPostsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  UserPosts create() => UserPosts();

  @override
  bool operator ==(Object other) {
    return other is UserPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userPostsHash() => r'0439471b4aeae56472982b700c8e382da44e5f11';

final class UserPostsFamily extends $Family
    with
        $ClassFamilyOverride<
          UserPosts,
          AsyncValue<List<Post>>,
          List<Post>,
          FutureOr<List<Post>>,
          (GraphQLClient, String)
        > {
  UserPostsFamily._()
    : super(
        retry: null,
        name: r'userPostsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserPostsProvider call(GraphQLClient client, String userID) =>
      UserPostsProvider._(argument: (client, userID), from: this);

  @override
  String toString() => r'userPostsProvider';
}

abstract class _$UserPosts extends $AsyncNotifier<List<Post>> {
  late final _$args = ref.$arg as (GraphQLClient, String);
  GraphQLClient get client => _$args.$1;
  String get userID => _$args.$2;

  FutureOr<List<Post>> build(GraphQLClient client, String userID);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Post>>, List<Post>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Post>>, List<Post>>,
              AsyncValue<List<Post>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

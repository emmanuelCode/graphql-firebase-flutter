// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      text: json['text'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'text': instance.text,
      'dateTime': instance.dateTime.toIso8601String(),
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userPostsHash() => r'48d9396b8a58b37d2dfc4e8b34fe71bd7e34d90b';

/// See also [UserPosts].
@ProviderFor(UserPosts)
final userPostsProvider = AsyncNotifierProvider<UserPosts, List<Post>>.internal(
  UserPosts.new,
  name: r'userPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserPosts = AsyncNotifier<List<Post>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

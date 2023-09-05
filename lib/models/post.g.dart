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

String _$userPostsHash() => r'51b142efa357caaf816562feff8e47b6f1b50e40';

/// See also [UserPosts].
@ProviderFor(UserPosts)
final userPostsProvider = AutoDisposeNotifierProvider<UserPosts, Post>.internal(
  UserPosts.new,
  name: r'userPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserPosts = AutoDisposeNotifier<Post>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member

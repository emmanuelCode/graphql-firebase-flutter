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

String _$userPostsHash() => r'68e064a3fdf53f224778c1d19f86c20595c52d9a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$UserPosts
    extends BuildlessAutoDisposeAsyncNotifier<List<Post>> {
  late final GraphQLClient client;

  Future<List<Post>> build(
    GraphQLClient client,
  );
}

/// See also [UserPosts].
@ProviderFor(UserPosts)
const userPostsProvider = UserPostsFamily();

/// See also [UserPosts].
class UserPostsFamily extends Family<AsyncValue<List<Post>>> {
  /// See also [UserPosts].
  const UserPostsFamily();

  /// See also [UserPosts].
  UserPostsProvider call(
    GraphQLClient client,
  ) {
    return UserPostsProvider(
      client,
    );
  }

  @override
  UserPostsProvider getProviderOverride(
    covariant UserPostsProvider provider,
  ) {
    return call(
      provider.client,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userPostsProvider';
}

/// See also [UserPosts].
class UserPostsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserPosts, List<Post>> {
  /// See also [UserPosts].
  UserPostsProvider(
    GraphQLClient client,
  ) : this._internal(
          () => UserPosts()..client = client,
          from: userPostsProvider,
          name: r'userPostsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userPostsHash,
          dependencies: UserPostsFamily._dependencies,
          allTransitiveDependencies: UserPostsFamily._allTransitiveDependencies,
          client: client,
        );

  UserPostsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.client,
  }) : super.internal();

  final GraphQLClient client;

  @override
  Future<List<Post>> runNotifierBuild(
    covariant UserPosts notifier,
  ) {
    return notifier.build(
      client,
    );
  }

  @override
  Override overrideWith(UserPosts Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserPostsProvider._internal(
        () => create()..client = client,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        client: client,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserPosts, List<Post>>
      createElement() {
    return _UserPostsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserPostsProvider && other.client == client;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, client.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserPostsRef on AutoDisposeAsyncNotifierProviderRef<List<Post>> {
  /// The parameter `client` of this provider.
  GraphQLClient get client;
}

class _UserPostsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserPosts, List<Post>>
    with UserPostsRef {
  _UserPostsProviderElement(super.provider);

  @override
  GraphQLClient get client => (origin as UserPostsProvider).client;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

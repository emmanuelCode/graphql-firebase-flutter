// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$graphQLClientHash() => r'e5988c9b0bc70713f7f53e0bc623fa020f938f68';

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

/// See also [graphQLClient].
@ProviderFor(graphQLClient)
const graphQLClientProvider = GraphQLClientFamily();

/// See also [graphQLClient].
class GraphQLClientFamily extends Family<GraphQLClient> {
  /// See also [graphQLClient].
  const GraphQLClientFamily();

  /// See also [graphQLClient].
  GraphQLClientProvider call(
    String token,
  ) {
    return GraphQLClientProvider(
      token,
    );
  }

  @override
  GraphQLClientProvider getProviderOverride(
    covariant GraphQLClientProvider provider,
  ) {
    return call(
      provider.token,
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
  String? get name => r'graphQLClientProvider';
}

/// See also [graphQLClient].
class GraphQLClientProvider extends AutoDisposeProvider<GraphQLClient> {
  /// See also [graphQLClient].
  GraphQLClientProvider(
    String token,
  ) : this._internal(
          (ref) => graphQLClient(
            ref as GraphQLClientRef,
            token,
          ),
          from: graphQLClientProvider,
          name: r'graphQLClientProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$graphQLClientHash,
          dependencies: GraphQLClientFamily._dependencies,
          allTransitiveDependencies:
              GraphQLClientFamily._allTransitiveDependencies,
          token: token,
        );

  GraphQLClientProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final String token;

  @override
  Override overrideWith(
    GraphQLClient Function(GraphQLClientRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GraphQLClientProvider._internal(
        (ref) => create(ref as GraphQLClientRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<GraphQLClient> createElement() {
    return _GraphQLClientProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GraphQLClientProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GraphQLClientRef on AutoDisposeProviderRef<GraphQLClient> {
  /// The parameter `token` of this provider.
  String get token;
}

class _GraphQLClientProviderElement
    extends AutoDisposeProviderElement<GraphQLClient> with GraphQLClientRef {
  _GraphQLClientProviderElement(super.provider);

  @override
  String get token => (origin as GraphQLClientProvider).token;
}

String _$authHash() => r'd22ef33f67f6f182eb57e78407683c286ac903d6';

/// See also [Auth].
@ProviderFor(Auth)
final authProvider = NotifierProvider<Auth, User?>.internal(
  Auth.new,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Auth = Notifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

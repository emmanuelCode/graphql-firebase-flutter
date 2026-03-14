// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Auth)
final authProvider = AuthProvider._();

final class AuthProvider
    extends $NotifierProvider<Auth, ({String? token, User? user})> {
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({String? token, User? user}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({String? token, User? user})>(
        value,
      ),
    );
  }
}

String _$authHash() => r'bc6bc5eef34b191f97ad02f306b504fec4f84260';

abstract class _$Auth extends $Notifier<({String? token, User? user})> {
  ({String? token, User? user}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({String? token, User? user}),
              ({String? token, User? user})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({String? token, User? user}),
                ({String? token, User? user})
              >,
              ({String? token, User? user}),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(graphQLClient)
final graphQLClientProvider = GraphQLClientFamily._();

final class GraphQLClientProvider
    extends $FunctionalProvider<GraphQLClient, GraphQLClient, GraphQLClient>
    with $Provider<GraphQLClient> {
  GraphQLClientProvider._({
    required GraphQLClientFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'graphQLClientProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$graphQLClientHash();

  @override
  String toString() {
    return r'graphQLClientProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<GraphQLClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GraphQLClient create(Ref ref) {
    final argument = this.argument as String;
    return graphQLClient(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GraphQLClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GraphQLClient>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GraphQLClientProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$graphQLClientHash() => r'6dd71aae93838421ae71ee2103b3b84d80329320';

final class GraphQLClientFamily extends $Family
    with $FunctionalFamilyOverride<GraphQLClient, String> {
  GraphQLClientFamily._()
    : super(
        retry: null,
        name: r'graphQLClientProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GraphQLClientProvider call(String token) =>
      GraphQLClientProvider._(argument: token, from: this);

  @override
  String toString() => r'graphQLClientProvider';
}

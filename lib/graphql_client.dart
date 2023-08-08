import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

GraphQLClient graphQLClientInit(String token) {
  final httpLink = HttpLink(
    'http://localhost:8080/graphql',
  );

  final authLink = AuthLink(
    getToken: () async =>
        _signFirebaseToken(token), //'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
    headerKey: 'X-Auth-Token',
  );

  Link link = authLink.concat(httpLink);

  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}

// original resource for this code
// https://github.com/hasura/graphql-engine/issues/6338#issuecomment-1017093962
// need to add these dependencies:
// flutter pub add jwt_decoder jaguar_jwt
String _signFirebaseToken(String token) {
  if (kDebugMode) {
    try {
      var decoded = JwtDecoder.decode(token);
      var claims = JwtClaim.fromMap(decoded, defaultIatExp: false);
      return issueJwtHS256(claims, 'secret');
    } catch (e) {
      print("Got unexpected exception (will return unmodified token): $e");
      return token;
    }
  } else {
    return token;
  }
}

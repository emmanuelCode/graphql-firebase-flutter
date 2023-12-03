import 'package:graphql/client.dart';

GraphQLClient graphQLClientInit(String token) {
  final httpLink = HttpLink(
    'http://localhost:8080/graphql',
  );

  final authLink = AuthLink(
    getToken: () async => token, //'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
    headerKey: 'X-Auth-Token',
  );

  Link link = authLink.concat(httpLink);

  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}
import 'package:graphql/client.dart';

GraphQLClient graphQLClientInit(String token) {
  final httpLink = HttpLink(
    'http://localhost:8080/graphql',
    defaultHeaders: {
      //'X-My-App-Auth': token,
      "X-Firebase-AppCheck": token,
    },
  );

  final authLink = AuthLink(
    getToken: () async => token, //'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
  );

  //Link link = authLink.concat(httpLink);

  Link link = httpLink;

  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}

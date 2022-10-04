import 'package:customer/apis/graph_ql_client.dart';
import 'package:customer/utils/app.dart';
import 'package:customer/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final policies = Policies(
  fetch: FetchPolicy.noCache,
);

class GraphQLClientAPI {
  var link = AuthLink(
    getToken: () async => 'Bearer ${App.localStorage.getString(PREF_TOKEN)}',
  ).concat(HttpLink(GraphQlClient.GRAPH_URL));

  GraphQLClient mClient = GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: HttpLink(
      GraphQlClient.GRAPH_URL,
      defaultHeaders: {
        'Authorization': 'Bearer ${App.localStorage.getString(PREF_TOKEN)}',
      },
      useGETForQueries: true,
    ),
    defaultPolicies: DefaultPolicies(
      watchQuery: policies,
      query: policies,
      mutate: policies,
    ),
  );
  static client() => ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: AuthLink(
        getToken: () async =>
        'Bearer ${App.localStorage.getString(PREF_TOKEN)}',
      ).concat(HttpLink(GraphQlClient.GRAPH_URL)),
    ),
  );

}

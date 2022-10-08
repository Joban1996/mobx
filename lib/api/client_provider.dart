import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/api/graphql_client.dart';
import '../utils/app.dart';
import '../utils/constants/constants_colors.dart';

final policies = Policies(
  fetch: FetchPolicy.noCache,
);

class GraphQLClientAPI {


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

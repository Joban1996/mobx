import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

import '../../../api/graphql_operation/customer_queries.dart';
import '../../../model/product/address_listing_model.dart';
import '../../../utils/app.dart';

class ProfileAddressesScreen extends StatelessWidget {
  ProfileAddressesScreen({Key? key}) : super(key: key);
  List<Map> addressList = [
    {
      'title': 'Home',
      'subtitle': '297, DLF Tower, B2,  Sector 23, Gurgaon, India 110010'
    },
    {
      'title': 'Work',
      'subtitle':
          '2nd 3rd 4th  Floor, Shashwat Business Park,Opp. Soma Textiles,Rakhial, Ahmedabad – 380023, Gujarat, India.'
    },
  ];

  Widget addressWidget(
      BuildContext context, String addressTitle, String addressSubtitle,int id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          addressTitle,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.edit,size: 20,)),
                            IconButton(
                                onPressed: () {

                                }, icon: Icon(Icons.close,size: 20,)),
                          ],
                        )
                      ],
                    ),
                    Text(
                      addressSubtitle,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              // Radio(
              //   value: '',
              //   onChanged: (value) {
              //
              //   }, groupValue: '',
              // ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(
          AppBarTitle("ADDRESSES", "Add, edit or delete your addresses "),
          appbar: AppBar(),
          onTapCallback: () {},
          leadingImage: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/back_arrow.png")),
        ),
        body:
        Query(
      options:
      QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(getListOfAddress),),
    builder: (QueryResult result,
    {VoidCallback? refetch, FetchMore? fetchMore}) {
    debugPrint("cart exception >>> ${result.exception}");
    if (result.hasException) {

    return Text(result.exception.toString());
    }
    if (result.isLoading) {
    return globalLoader();
    }
    var parsed = AddressListingModel.fromJson(result.data!);
    var addressesList = parsed.customer!.addresses!;
    debugPrint("get addresses data >>> ${result.data}");
    debugPrint("get auth token >>> ${App.localStorage.getString(PREF_TOKEN)}");
    return
        Container(
          color: Colors.white.withOpacity(0.8),
          child: Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: addressesList.length,
                  itemBuilder: (context, index) {
                    var model = addressesList[index];
                    return addressWidget(
                        context, "Home", "${model.street![0]!}, ${model.city}, ${model.region!.region!}, India.",model.id!);
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                    onTap: () {
                  Navigator.pushNamed(context, Routes.googleMapScreen);
                    },
                    text: Strings.addNewAddressButton,
                    isTrailing: false,
                  ),
                ),
              ),
            ],
          ),
        );}));
  }
}

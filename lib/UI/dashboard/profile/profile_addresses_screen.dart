import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/globally_common/app_button_leading.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/dashboard/address_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../../../api/graphql_operation/customer_queries.dart';
import '../../../model/product/address_listing_model.dart';
import '../../../utils/app.dart';
import 'add_address_screen.dart';

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
  late VoidCallback reFresh;

  Widget addressWidget(
      BuildContext context, String addressTitle, String addressSubtitle,int addressId,String name,String lastName,Addresses data) {
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
                          "$name $lastName",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Consumer2<AddressProvider,LoginProvider>(
                          builder: (_,addProVal,loginProVal,child){
                            return Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>
                                          AddAddressScreen(street: data.street.toString(),flatAddress: data.street![0].toString(), city: data.city.toString(),
                                              state: data.region!.region.toString(), pinCode: data.postcode.toString(),
                                              country: "India",isEdit: true,fistName: name,lastName: lastName,addId: data.id!,)));
                                    }, icon: Icon(Icons.edit,size: 20,)),
                                IconButton(
                                    onPressed: () {
                                      loginProVal.setLoadingBool(true);
                                      addProVal.hitDeleteAddress(id: addressId).then((value){
                                        loginProVal.setLoadingBool(false);
                                        reFresh.call();
                                      });
                                    }, icon: Icon(Icons.close,size: 20,)),
                              ],
                            );
                          },
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
          const AppBarTitle("ADDRESSES", ""),
          appbar: AppBar(),
          onTapCallback: () {},
          leadingImage: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset("assets/images/back_arrow.png")),
        ),
        body:
       CommonLoader(
         screenUI:  Query(
             options:
             QueryOptions(
               fetchPolicy: FetchPolicy.networkOnly,
               document: gql(getListOfAddress),),
             builder: (QueryResult result,
                 {VoidCallback? refetch, FetchMore? fetchMore}) {
               reFresh = refetch!;
               debugPrint("cart exception >>> ${result.exception}");
               if (result.hasException) {
                 if(result.exception!.graphqlErrors[0].extensions!['category'].toString() == "graphql-authorization"){
                   WidgetsBinding.instance.addPostFrameCallback((_) {
                     App.localStorage.clear();
                     Navigator.pushReplacementNamed(context, Routes.loginScreen);});
                 }
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
                           padding: EdgeInsets.only(bottom: getCurrentScreenHeight(context)/8),
                           shrinkWrap: true,
                           itemCount: addressesList.length,
                           itemBuilder: (context, index) {
                             var model = addressesList[index];
                             return addressWidget(

                                 context, "Home", "${model.street![0]!}, ${model.postcode}, ${model.city}, ${model.region!.region!},"
                                 " India.",model.id!,model.firstname.toString(),model.lastname.toString(),model);
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
                 );}),
       ));
  }
}

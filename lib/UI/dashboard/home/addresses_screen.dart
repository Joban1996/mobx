import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/api/graphql_operation/customer_queries.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/model/product/address_listing_model.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/dashboard/address_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../../../utils/app.dart';
import '../../../utils/constants/strings.dart';
class AddressesScreen extends StatelessWidget {
  const AddressesScreen({Key? key}) : super(key: key);




  Widget addressWidget(BuildContext context, String addressSubtitle,int index,Addresses data)
  {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(data.defaultShipping == true){
        context.read<AddressProvider>().setSelectedValue(index);
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(addressSubtitle,style: Theme.of(context).textTheme.bodySmall,),
              ),
              Consumer2<AddressProvider,LoginProvider>(
                builder: (_,val,val2,child){
                  return  Radio(
                    value: index,
                    onChanged: (value) {
                        val.setSelectedValue(value!);
                        // val2.setLoadingBool(true);
                        // val.hitShippingDeliveryAddress(street: data.street![0], firstName: data.firstname.toString(),
                        //     lastName: data.lastname.toString(), city: data.city.toString(),
                        //     pinCode: data.postcode.toString(),
                        //     phonNumber: data.telephone.toString(), isBillingAddress: true,
                        //     cartId: App.localStorage.getString(PREF_CART_ID).toString()).then((value) => {
                        //       //Navigator.pushReplacementNamed(context, Routes.shoppingCart),
                        // val2.setLoadingBool(false)
                        // });
                    }, groupValue: val.getSelected,
                  );
                },
              )
            ],
          ),
        ),
        const Divider(
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
              onTap: () => Navigator.pop(context,true),
              child: Image.asset("assets/images/back_arrow.png")),
        ),
      body:
      CommonLoader(screenUI: Query(
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
            debugPrint("get orders data >>> ${App.localStorage.getString(PREF_TOKEN)}");
            return
              Stack(
                children: [
                  Column(
                    children: [
                     addressesList.isEmpty ?  Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Text("Click on below button to add new address",style: Theme.of(context).textTheme.bodySmall,),
                     ) :  ListView.builder(
                          shrinkWrap: true,
                          itemCount: addressesList.length,
                          itemBuilder: (context, index)
                          {
                            var model=addressesList[index];
                            return addressWidget(context,"${model.street![0]!}, ${model.city}, ${model.region!.region!}, India."
                                ,index,model);
                          }
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,10,10,5),
                        child: AppButton(
                          onTap: () {
                            context.read<AddressProvider>().setFromWhere("order");
                            Navigator.pushReplacementNamed(context, Routes.googleMapScreen);
                          },
                          text: Strings.addNewAddressButton,
                          isTrailing: false,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Consumer2<AddressProvider,LoginProvider>(
                          builder: (_,val,val1,child){
                            return AppButton(
                              onTap: () {
                                if(addressesList.isNotEmpty) {
                                  val1.setLoadingBool(true);
                                  val.hitShippingDeliveryAddress(
                                      street: addressesList[val.getSelected]
                                          .street![0],
                                      firstName: addressesList[val.getSelected]
                                          .firstname.toString(),
                                      lastName: addressesList[val.getSelected]
                                          .lastname.toString(),
                                      city: addressesList[val.getSelected].city
                                          .toString(),
                                      pinCode: addressesList[val.getSelected]
                                          .postcode.toString(),
                                      phonNumber: addressesList[val.getSelected]
                                          .telephone.toString(),
                                      isBillingAddress: true,
                                      cartId: App.localStorage.getString(
                                          PREF_CART_ID).toString()).then((
                                      value) =>
                                  {
                                    val.hitSetBillingAddress(
                                        street: addressesList[val.getSelected]
                                            .street![0],
                                        firstName: addressesList[val
                                            .getSelected].firstname.toString(),
                                        lastName: addressesList[val.getSelected]
                                            .lastname.toString(),
                                        city: addressesList[val.getSelected]
                                            .city.toString(),
                                        pinCode: addressesList[val.getSelected]
                                            .postcode.toString(),
                                        phonNumber: addressesList[val
                                            .getSelected].telephone.toString(),
                                        isBillingAddress: true,
                                        cartId: App.localStorage.getString(
                                            PREF_CART_ID).toString()).then((
                                        value) {
                                      val1.setLoadingBool(false);
                                      Navigator.pushReplacementNamed(
                                          context, Routes.payment);
                                    }),
                                  });
                                }else{
                                  Utility.showNormalMessage("Add your address first to proceed.");
                                }
                              },
                              text: Strings.proceedToPayment,
                              isTrailing: false,
                            );
                            },
                        ),
                      ),
                    ],
                  ),
                ],
              );}))
    );
  }
}

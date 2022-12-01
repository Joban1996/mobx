import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/dashboard/item_info_arrow_forward.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/dashboard/payment_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../model/product/CartListModel.dart';
import '../../../utils/app.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _razorpay = Razorpay(); //razorpay instance
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // remove all listeners
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    debugPrint('payment succeed ::: Payment Id > ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    debugPrint('payment fails ::: ${response.error}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    debugPrint('payment external wallet ::: ${response.walletName}');
  }
Map<String,dynamic> options(int amount,String name,String des,String contact,String email){
  return  {
    'key': 'rzp_test_S3h5y6fLfZ28tI',
    'amount': amount*100,
    'name': 'Mobex',
    'description': 'test',
    'prefill': {
      'contact': contact,
      'email': email
    }
  };
}

  Widget _priceDesRow(
      String title, String value, BuildContext context, var localColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Utility.getColorFromHex(localColor)),
        )
      ],
    );
  }

  Widget _column(BuildContext context,CartListModel data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("PRICE DETAILS ( ${data.cart!.items!.length} Items)",style: Theme.of(context).textTheme.bodyMedium,),
          verticalSpacing(heightInDouble: 0.01, context: context),
          _priceDesRow("Sub Total", "₹${data.cart!.prices!.subtotalExcludingTax!.value}", context, globalBlackColor),
          _priceDesRow("Discount", data.cart!.prices!.discounts!=null ?
          "₹${data.cart!.prices!.discounts![0].amount!.value}": "₹0", context, globalGreenColor),
          _priceDesRow("Delivery Fee", "₹0", context, globalBlackColor),
          dividerCommon(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount",style: Theme.of(context).textTheme.bodyMedium),
              Text("₹${data.cart!.prices!.grandTotal!.value}", style: Theme.of(context).textTheme.bodyMedium,)
            ],
          ),
          dividerCommon(context),
        Padding(
          padding: const EdgeInsets.only(top: 6,bottom: 6),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.deliver_address, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 3,),
                Text( "${data.cart!.shippingAddresses![0].street![0].toString()}, "
                    "${data.cart!.shippingAddresses![0].city.toString()}, "
                    "${data.cart!.shippingAddresses![0].region!.label.toString()} ",
                  style: Theme.of(context).textTheme.bodySmall,maxLines: 1,overflow: TextOverflow.ellipsis,)
              ]),
        ),
          dividerCommon(context),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context,index){
                return const Divider();
              },
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.cart!.availablePaymentMethods!.length,
                itemBuilder: (context,index){
                  /*if(data.cart!.selectedPaymentMethod!.code.toString() ==
                      data.cart!.availablePaymentMethods![index].code.toString()) {
                    context.read<PaymentProvider>().setSelectedIndex(index, data.cart!.availablePaymentMethods![index].code.toString());
                  }*/
              return Consumer2<PaymentProvider,LoginProvider>(
                builder: (_,val,val2,child){
                  return GestureDetector(
                    onTap: () {
                      val2.setLoadingBool(true);
                      val.hitSetPaymentMethod(cartId: App.localStorage.getString(PREF_CART_ID).toString(),
                          code: data.cart!.availablePaymentMethods![index].code.toString()).then((value){
                        val2.setLoadingBool(false);
                        if(value){
                          val.setSelectedIndex(index,data.cart!.availablePaymentMethods![index].code.toString());
                          val.toggle();
                        }
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 6,bottom: 6),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.cart!.availablePaymentMethods![index].code == "cashondelivery" ? "Cash On Delivery"
                                : "Credit Card / Debit Card / NetBanking / UPI / Wallet",
                                style: val.getSelectedIndex == index ?
                                Theme.of(context).textTheme.bodyMedium!.copyWith(color: Utility.getColorFromHex(globalOrangeColor))
                                    : Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(height: 3,),
                            Text(data.cart!.availablePaymentMethods![index].title.toString(),
                              style: val.getSelectedIndex == index ?
                              Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex(globalOrangeColor)):
                                  Theme.of(context).textTheme.bodySmall,maxLines: 1,overflow: TextOverflow.ellipsis,)
                          ]),
                    ),
                  );
                },
              );
            }),
          ),

          dividerCommon(context),
          SizedBox(
            height: getCurrentScreenHeight(context) * 0.03,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        AppBarTitle(Strings.payment_app_bar, "2 items added "),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
      ),
      body:
     CommonLoader(screenUI:  Query(
         options:
         QueryOptions(
             fetchPolicy: FetchPolicy.networkOnly,
             document: gql(cartList), variables: {
           'cart_id': App.localStorage.getString(PREF_CART_ID)!
         }),
         builder: (QueryResult result,
             {VoidCallback? refetch, FetchMore? fetchMore}) {
           debugPrint("cart exception get shopping cart >>> ${result}");
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
           var parsed = CartListModel.fromJson(result.data!);
           var productItems = parsed.cart!.items!;
           debugPrint("cart list data in payment screen >>> ${productItems.length}");
           debugPrint("set payment method >>>>> j ${result.data!['cart']['selectedPaymentMethod']}");
           return
             Stack(
               children: [
                 _column(context,parsed),
                 Align(
                   alignment: Alignment.bottomCenter,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Consumer2<PaymentProvider,LoginProvider>(
                       builder: (_,val1,val2,child){
                         return AppButton(
                             onTap: () async{
                              // val2.setLoadingBool(true);
                               if(parsed.cart!.shippingAddresses![0].selectedShippingMethod == null){
                                 val1.hitSetShippingMethod(cartId: App.localStorage.getString(PREF_CART_ID).toString());
                               }
                               if(parsed.cart!.selectedPaymentMethod != null) {
                                 if (val1.getSelectedCode == "razorpay") {
                                   _razorpay.open(options(int.parse(
                                       parsed.cart!.prices!.grandTotal!.value!
                                           .round().toString()),
                                       "name", "des", val2.getMobileNumber,
                                       App.localStorage.getString(
                                           PREF_USER_EMAIL).toString())
                                   );
                                 }
                                 await val1.hitPlaceOrder(
                                     cartId: App.localStorage.getString(
                                         PREF_CART_ID).toString()).then((
                                     value) async{
                                   //val2.setLoadingBool(false);
                                   if (value) {
                                     await App.localStorage.remove(PREF_CART_ID);
                                     debugPrint("cart id removed >>>>> ${App.localStorage.getString(PREF_CART_ID)}");
                                     navigate();
                                   }
                                 });
                               }else{
                                 Utility.showNormalMessage("Please select a shipping method");
                               }
                             },
                             text: "PLACE ORDER");
                       },
                     ),
                   ),
                 )
               ],
             );}))
    );
  }
 navigate(){
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.orderConfirmed, (
        _) => false);
  }
}

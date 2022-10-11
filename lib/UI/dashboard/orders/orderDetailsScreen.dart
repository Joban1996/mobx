import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/outline_button.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/utilities.dart';
class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({Key? key}) : super(key: key);

  Widget cartItemView(BuildContext context,String id, String status, String image, String title, String subTitle,String salePrice, String actualPrice)
  {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            // width: getCurrentScreenWidth(context)/4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Utility.getColorFromHex(globalGreyColor))),
            //height: getCurrentScreenHeight(context)/5.5,
            child: Image.asset(image,fit: BoxFit.cover,),),
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(text: TextSpan(children: [
                TextSpan(
                  text: "ID:",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12,height: 1.3)
                ),
                TextSpan(
                    text: id,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12,height: 1.3),
                ),
              ])),
              RichText(text: TextSpan(children: [
                TextSpan(
                    text: "STATUS:",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12,height: 1.3)
                ),
                TextSpan(
                  text: status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Utility.getColorFromHex(globalGreenColor)
                  ),
                ),
              ])),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subTitle,
                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 13)),
              Text(salePrice,style: Theme.of(context).textTheme.caption,),
              Text('11th Aug 2022 / 09.40AM',style: Theme.of(context).textTheme.caption,),
            ],
          ),
        ),
        dividerCommon(context),
      ],
    );
  }

  Widget detailView(BuildContext context,String title, String subTitle, String subTitle2, String subTitle3)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(title,
                 style: Theme.of(context).textTheme.bodyText2
             ),
             Visibility(
               visible: subTitle.isNotEmpty,
               child: Text(subTitle,
                   style: Theme.of(context).textTheme.caption
               ),
             ),
             Visibility(
               visible: subTitle2.isNotEmpty,
               child: Text(subTitle2,
                   style: Theme.of(context).textTheme.caption
               ),
             ),
             Visibility(
               visible: subTitle3.isNotEmpty,
               child: Text(subTitle3,
                   style: Theme.of(context).textTheme.caption
               ),
             ),
           ],
         ),
       ),
        dividerCommon(context),
      ],
    );
  }

  Widget _priceDesRow(
      String title, String value, BuildContext context, var localColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.caption),
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

  Widget PriceView(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PRICE DETAILS ( 2 Items)",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          verticalSpacing(heightInDouble: 0.01, context: context),
          _priceDesRow("Sub Total", "₹110,198", context, globalBlackColor),
          _priceDesRow("Discount", "₹-31,602", context, globalGreenColor),
          _priceDesRow("Delivery Fee", "₹100", context, globalBlackColor),
          _priceDesRow("Coupon", "₹0", context, globalBlackColor),
          dividerCommon(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount",
                  style: Theme.of(context).textTheme.bodyText2),
              Text(
                "₹110,298",
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
          dividerCommon(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        Text(Strings.viewDetailsButton,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600)),
        appbar: AppBar(),
        onTapCallback: () {},
        trailingAction: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.phone_outlined,color: Utility.getColorFromHex(globalGreyColor))
          ),
        ],
        leadingImage: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cartItemView(context,"#123121213","DELIVERED", 'assets/images/iphone_pic.png', 'APPLE', 'Refurbished Apple iPhone 12 Mini White 128 GB ', '₹55,099', '₹70,099'),
          detailView(context, "BASIC DETAIL", "John Smith", "9090909090 / john@example.com",""),
          detailView(context, "PICKUP DATE & TIME", "2nd 3rd 4th  Floor, Shashwat Business Park,Opp. Soma Textiles,Rakhial, Ahmedabad – 380023, Gujarat, India.", "",""),
          detailView(context, "PAYMENT DETAILS", "Paid by: Card",
            "Transaction ID: 923222090909090","Order ID:  #123123123"),
          PriceView(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flexible(child: OutLineButtonWidget(text: "Download Invoice", onTap: (){})),
          )
        ],
      ),
    );
  }
}

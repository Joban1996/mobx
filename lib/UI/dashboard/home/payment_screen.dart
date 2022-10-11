import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/dashboard/item_info_arrow_forward.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

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

  Widget _column(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
          ItemInfoArrowForward(
              onTap: () {},
              title: Strings.deliver_address,
              description:
                  "John Smith, 2nd 3rd 4th  Floor, Shashwat Business Park,Opp....."),
          dividerCommon(context),
          ItemInfoArrowForward(
              onTap: () {},
              title: Strings.crid_debit_text,
              description: "By RazerPay"),
          dividerCommon(context),
          ItemInfoArrowForward(
              onTap: () {},
              title: Strings.cashOnDelivery,
              description: Strings.cashOnDelivery_subTitle),
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
        // trailingAction: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 10),
        //     child: Icon(
        //       Icons.star_border_outlined,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          _column(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.orderConfirmed);
                  },
                  text: "PAY NOW"),
            ),
          )
        ],
      ),
    );
  }
}

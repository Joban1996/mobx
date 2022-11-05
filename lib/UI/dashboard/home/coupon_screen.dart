import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/common_loader.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';

import '../../../utils/app.dart';
class CouponScreen extends StatelessWidget {
   CouponScreen({Key? key}) : super(key: key);
final couponCont  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle("COUPON", ""),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
      ),
      body: CommonLoader(screenUI:  Container(
        padding: const EdgeInsets.all(8.0),
        child:  TextField(
          controller: couponCont,
          decoration: InputDecoration(
            hintText: "Enter your coupon code",
            hintStyle: Theme.of(context).textTheme.bodySmall,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalGreyColor)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 1, color: Utility.getColorFromHex(globalOrangeColor)),
            ),
            suffixIcon: Consumer2<ProductProvider,LoginProvider>(
              builder: (_,val,val2,child){
                return GestureDetector(
                    onTap: (){
                      if(couponCont.text.isNotEmpty) {
                        val2.setLoadingBool(true);
                        val.hitApplyCouponMutation(
                            cartId: App.localStorage.getString(PREF_CART_ID).toString(),
                            couponCode: couponCont.text).then((value) {
                          val2.setLoadingBool(false);
                          if(value) Navigator.of(context).pop(true);
                        });
                      }
                    },
                    child: Icon(Icons.arrow_right_alt_sharp,color: Colors.grey,));
              },
            ),
          ),
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/outline_button.dart';
import 'package:mobx/utils/constants/strings.dart';
import 'package:mobx/utils/routes.dart';

class OrdersHome extends StatelessWidget {
  const OrdersHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCommon(
          Text(Strings.myOrderAppTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w600)),
          appbar: AppBar(),
          onTapCallback: () {},
          leadingImage: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: OutLineButtonWidget(text: "Oder Details".toUpperCase(), onTap: (){
            Navigator.pushNamed(
                context, Routes.orderDetails);
          }),
        )
    );
  }
}



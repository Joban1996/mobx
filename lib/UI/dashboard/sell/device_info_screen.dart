import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/common_widgets/globally_common/brand_gridView.dart';
class DeviceInfoScreen extends StatelessWidget {
  const DeviceInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle("DEVICE INFO", "Select correct variant of your phone"),
        appbar: AppBar(),
        onTapCallback: () {
          Navigator.of(context).pop();
        },
        leadingImage: Image.asset("assets/images/back_arrow.png"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 50.0,
                child: BrandGridView(brandImage: 'assets/images/iphone_mini.png', brandName: '', callback: ()=>null,)),
            title: Column(
              children: [
                Text('Apple iPhone 12 Mini'),

              ],
            ),
          )
        ],
      ),
    );
  }
}

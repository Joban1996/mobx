import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/dashboard/app_bar_title.dart';
import 'package:mobx/common_widgets/globally_common/app_bar_common.dart';
import 'package:mobx/utils/constants/strings.dart';
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        const AppBarTitle(
            Strings.aboutUsAppTitle, ''),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset("assets/images/back_arrow.png")),
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width*0.02,
          right: MediaQuery.of(context).size.width*0.02,
          top: MediaQuery.of(context).size.height*0.02,
          bottom: MediaQuery.of(context).size.height*0.02,
        ),
        child: SingleChildScrollView(
          child: Text(Strings.aboutUsContent,
              style: Theme.of(context).textTheme.caption
          ),
        ),
      ),
    );
  }
}

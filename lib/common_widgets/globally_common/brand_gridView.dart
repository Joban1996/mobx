import 'package:flutter/material.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
class BrandGridView extends StatelessWidget {

  String brandImage,brandName;
  VoidCallback callback;
  BrandGridView({Key? key, required this.brandImage, required this.brandName, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        //padding: EdgeInsets.all(20),
        //width: getCurrentScreenWidth(context)/2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Utility.getColorFromHex(globalGreyColor))),
        //height: getCurrentScreenHeight(context)/4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(child: Image.asset(brandImage,
            height: 60.0,width: 60.0,)),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(brandName,
                  style: Theme.of(context).textTheme.caption
              ),
            ),
          ],
        ),
      ),
    );
  }
}

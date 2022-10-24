import 'package:flutter/material.dart';
import 'package:mobx/utils/utilities.dart';

class HorizontalCircleBrandList extends StatelessWidget {
  String brandImage, brandName;
  Color   colorName;

  HorizontalCircleBrandList(
      {Key? key,
      required this.brandImage,
      required this.brandName,
      required this.colorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: getCurrentScreenHeight(context)*0.1,
          width: getCurrentScreenHeight(context)*0.1,
          margin: EdgeInsets.only(right: 3, left: 3),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorName
          ),
          child: brandImage != "null" ? Image.network(brandImage.toString()) : null,
        ),
        Padding(
          padding: EdgeInsets.only(right: 2,left: 2,top: 4),
          child: Text(
            brandName,
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
          ),
        )
      ],
    );
  }
}

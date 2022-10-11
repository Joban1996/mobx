import 'package:flutter/material.dart';

class HorizontalCircleBrandList extends StatelessWidget {
  String brandImage, brandName;
  Color colorName;

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
          margin: EdgeInsets.only(right: 3, left: 3),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorName
          ),
          child: Image.asset(brandImage),
        ),
        Text(
          brandName,
          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
        )
      ],
    );
  }
}

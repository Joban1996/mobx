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
    return Container(
      width: MediaQuery.of(context).size.width*0.18,
      child: Column(
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
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
          )
        ],
      ),
    );
  }
}

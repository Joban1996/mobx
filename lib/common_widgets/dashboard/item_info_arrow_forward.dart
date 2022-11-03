import 'package:flutter/material.dart';

import '../../utils/constants/constants_colors.dart';
import '../../utils/utilities.dart';

class ItemInfoArrowForward extends StatelessWidget {
  const ItemInfoArrowForward(
      {required this.onTap,
      required this.title,
      required this.description,
      Key? key})
      : super(key: key);
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(title, style: Theme.of(context).textTheme.bodyText2),
        SizedBox(height: 3,),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Expanded(
                child: Text(description,
                    style: Theme.of(context).textTheme.caption),
              ),
              title == "EMI OPTION" ? Image.asset("assets/images/zest_brand.png") : Container(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Utility.getColorFromHex(globalSubTextGreyColor),
              )
            ],
          ),
        )
      ]),
    );
  }
}

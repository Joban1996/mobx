import 'package:flutter/material.dart';

import '../../utils/constants/constants_colors.dart';
import '../../utils/utilities.dart';

class ItemInfoArrowForward extends StatelessWidget {
  const ItemInfoArrowForward(
      {required this.onTap,
      required this.title,
      required this.description,this.trailingIcon,
      Key? key})
      : super(key: key);
  final String title;
  final String description;
  final VoidCallback onTap;
  final Widget? trailingIcon;

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
                    style: Theme.of(context).textTheme.bodySmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
              ),
              title == "EMI OPTION" ? Image.asset("assets/images/zest_brand.png") : Container(),
              trailingIcon ?? Icon(
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

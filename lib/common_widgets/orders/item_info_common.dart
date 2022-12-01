import 'package:flutter/material.dart';

import '../../model/product/getOrdersModel.dart';
import '../../utils/constants/constants_colors.dart';
import '../../utils/utilities.dart';



class ItemInfoCommon extends StatelessWidget {
   const ItemInfoCommon({Key? key,required this.number,
     required this.status,required this.productName,required this.grandTotal,required this.orderDate}) : super(key: key);
   final String number;
   final String status;
   final String productName;
   final String grandTotal;
   final String orderDate;
   @override
  Widget build(BuildContext context) {
    List<String> splitAndTime = orderDate.toString().split(' ');
    List<String> splitDate = splitAndTime[0].split("-");
    List<String> splitTime = splitAndTime[1].split(":");
    return Column(
      children: [
        ListTile(
          title:  Padding(
            padding: const EdgeInsets.fromLTRB(0, 6 , 0, 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(text: TextSpan(children: [
                  TextSpan(
                      text: "ID: ",
                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12)
                  ),
                  TextSpan(
                    text: number,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),
                  ),
                ])),
                RichText(text: TextSpan(children: [
                  TextSpan(
                      text: "STATUS: ",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12)
                  ),
                  TextSpan(
                    text: status,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Utility.getColorFromHex(globalGreenColor)
                    ),
                  ),
                ])),
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(productName,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13)),
              const SizedBox(height: 5,),
              Text(grandTotal,style: Theme.of(context).textTheme.bodySmall,),
              Text("${splitDate[2]}th ${getMonthName(splitDate[1])} ${splitDate[0]} / ${splitTime[0]}:${splitTime[1]} ",style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ),
        dividerCommon(context),
      ],
    );
  }
  String getMonthName(String value){
    switch(int.parse(value)){
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "NA";
    }
  }
}

import 'package:flutter/material.dart';
import '../../utils/constants/constants_colors.dart';
import '../../utils/utilities.dart';



class ItemInfoCommon extends StatelessWidget {
   const ItemInfoCommon({Key? key,required this.number,this.price = '',
     required this.status, required this.productName,required this.grandTotal,required this.orderDate}) : super(key: key);
   final String number;
   final String status;
   final List<String> productName;
   final List<String> grandTotal;
   final String price;
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
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12.5),
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
              productName.isNotEmpty ? ListView.builder(
                padding: EdgeInsets.only(top: 5),
                shrinkWrap: true,
                  itemCount: productName.length,
                  itemBuilder: (context,index){
                return _column(productName[index], grandTotal[index], context);
              }): Container(),
                const SizedBox(height: 5,),
              productName.isEmpty ? RichText(text: TextSpan(children: [
                TextSpan(
                    text: "Price: ",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.5)
                ),
                TextSpan(
                  text: "₹$price",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),
                ),
              ])) : Container(),
              productName.isNotEmpty ? Container() : verticalSpacing(heightInDouble: 0.002, context: context) ,
              Text("${splitDate[2]}th ${getMonthName(splitDate[1])} ${splitDate[0]} / ${splitTime[0]}:${splitTime[1]} ",style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ),
        dividerCommon(context),
      ],
    );
  }

  Widget _column(String name,String price,BuildContext context){
     return Container(
       padding: EdgeInsets.only(bottom: 7),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(name,style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12)),
           verticalSpacing(heightInDouble: 0.005, context: context),
           Text("₹$price",style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),),
         ],
       ),
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

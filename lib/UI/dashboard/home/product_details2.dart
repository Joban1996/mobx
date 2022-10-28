import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mobx/model/product_description_model.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import '../../../utils/routes.dart';



class ProductDetails2 extends StatelessWidget {
  late Items dataItem;
  ProductDetails2( this.dataItem,{Key? key}) : super(key: key);

  bool _checkbox = false;
  List<String> titleForDetail = ["PRODUCT DESCRIPTION","SHIPPING POLICY","REFUND POLICY","FAQ"];


Widget itemColumn(String txt1,String txt2,BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start ,
    children: [
      Text(txt1,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 11,height: 3)),
      Text(txt2,style: Theme.of(context).textTheme.caption,)
    ],
  );
}
Widget titleRow(BuildContext context,String txt,int itemIndex){
  return Row(
    children: [
      Expanded(child: Text(txt,style: Theme.of(context).textTheme.bodyMedium)),
      Visibility(
        visible: txt=="SPECIFICATIONS",
        child: Checkbox(
            value: _checkbox,
            onChanged: (value){
              _checkbox=value!;
              Navigator.pushNamed(context, Routes.compare);
            }
        ),
      ),
       Consumer<ProductProvider>(
         builder: (_,val,child){
           return IconButton(
               padding: EdgeInsets.zero,
               constraints: BoxConstraints(),
               onPressed: (){
                 val.setItemIndex(itemIndex);
                 if(val.getItemIndex == itemIndex){
                   val.setIsExpand();
                 }
               }, icon: val.getIsExpand ? const Icon(Icons.keyboard_arrow_down_rounded)
               : const Icon(Icons.keyboard_arrow_up_rounded));
         },
       )
    ],
  );
}
  Widget specifications(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent,unselectedWidgetColor: Colors.black),
      child: ListTileTheme(
        dense: true,
        child: ExpansionTile(
          initiallyExpanded: true,
            iconColor: Colors.black,
            title: Text("SPECIFICATIONS",style: Theme.of(context).textTheme.bodyMedium),
            tilePadding: EdgeInsets.zero,
            children: [Row(
              children: [
                Expanded(child: itemColumn("Brand","${dataItem.modelName}",context)),
                Expanded(child: itemColumn("Colour",dataItem.colour.toString()??"-",context)),
              ],
            ),
              Row(
                children: [
                  Expanded(child: itemColumn("Weight",dataItem.itemWeight??"-",context)),
                  Expanded(child: itemColumn("Dimensions",dataItem.productDimensions??"-",context)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: itemColumn("Memory Storage Capacity","${dataItem.memoryStorageCapacity ?? "-"} GB",context)),
                  Expanded(child: itemColumn("Country of Origin",dataItem.countryOfManufacture??"-",context)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: itemColumn("Whats in the box","1 Year Warranty Card, Charger, ‎Handset",context)),
                  Expanded(child: itemColumn("Quality","Excellent",context)),
                ],
              )]),
      ),
    );
  }
  Widget descriptions(BuildContext context,String title,String descData,int itemIndex){
  return Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent,unselectedWidgetColor: Colors.black),
    child: ListTileTheme(
      dense: true,
      child: ExpansionTile(
        iconColor: Colors.black,
        title: Text(title,style: Theme.of(context).textTheme.bodyMedium),
        tilePadding: EdgeInsets.zero,
        children: [HtmlWidget(descData,textStyle: Theme.of(context).textTheme.bodySmall,)]),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
  return Container(
    color: Colors.white.withOpacity(0.8),
    child:
      Column(
        children: [
          specifications(context),
          dividerCommon(context),
          ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (contect,inde){
              return const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Divider(height: 1,));
            },
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context,index){
                List<String> descriptionData = [dataItem.description!.html.toString(),"Mobex is committed to deliver the best products to its "
                    "users for which we perform 65+ quality checks.","We have 100% refund policy If you change your"
                    " mind before the order is dispatched from our warehouse.","What are Refurbished Products? Refurbished products are devices "
                    "restored to full working condition, as new, as they were either pre-owned or used as display models"];
                return descriptions(context, titleForDetail[index], descriptionData[index],index);
          }),
        ],
      )
  );
  }
}

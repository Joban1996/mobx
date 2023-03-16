import 'package:flutter/material.dart';
import 'package:mobx/common_widgets/globally_common/app_button.dart';
import 'package:mobx/model/product/filter_data_model.dart';
import 'package:mobx/provider/dashboard/filter_provider.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';



class FilterView extends StatefulWidget {
   FilterView(this.filterData,{Key? key}) : super(key: key);

   final filterData;

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {

  List _isChecked = [];
  Map<String,dynamic>  dataValue = {};
  List<String> valueList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _isChecked =  List.filled(widget.filterData.length, null, growable: true);
      valueList = List.filled(8, "", growable: true);
    //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(context.read<FilterProvider>().getIsCheckedList == null) {
        for (int i = 0; i < widget.filterData.length; i++) {
          _isChecked[i] =
          List<bool>.filled(widget.filterData![i].options!.length, false);
        }
      }else{
          _isChecked = List.from(context.read<FilterProvider>().getIsCheckedList!);
      }
   // });
   //    debugPrint("list of bools >>>>> $_isChecked");
   //  debugPrint("list of values >>>>> $valueList");
   }

  @override
  Widget build(BuildContext context) {
    Widget topView(List<Aggregations>? data){
      return data!.isNotEmpty ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (){
            context.read<FilterProvider>().setValue = null;
            if(context.read<FilterProvider>().getIsCheckedList == null) {
              setState(() {
                for (int i = 0; i < widget.filterData.length; i++) {
                  _isChecked[i] =
                  List<bool>.filled(widget.filterData![i].options!.length, false);
                }
              });
            }
            valueList = List.filled(8, "", growable: true);
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Text("CLEAR ALL",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Utility.getColorFromHex(globalOrangeColor))),
          ),
        )
      ): Container();
    }

    Widget bottomView(List<Aggregations>? data){
      return Consumer2<ProductProvider,FilterProvider>(
        builder: (_,val,valFilterPro,child){
          return data!.isNotEmpty ? Padding(
            padding: const EdgeInsets.all(8.0),
            child:  AppButton(isTrailing: false,onTap: (){
                  List<String> priceValue = valueList[0].toString().split('_');
                  if(priceValue.length ==2){
                    val.setPrice(priceValue[0]);
                    val.setPriceTo(priceValue[1]);
                  }
                val.setManufacturer(valueList[2]);
                val.setColor(valueList[3]);
                val.setOs(valueList[4]);
                val.setBrand(valueList[5]);
                val.setCountry(valueList[6]);
                val.setStorageCapacity(valueList[7]);
                valFilterPro.setValue = _isChecked;
                //Navigator.popUntil(context, (route) => route.settings.name == Routes.productListing);
              //Navigator.popAndPushNamed(context, Routes.productListing);
              Navigator.pop(context,true);
            }, text: "APPLY"),
          ): Container();
        },
      );
    }
    Widget valueRow(List<Aggregations>? data){

      return Consumer<ProductProvider>(
        builder: (_,value,child){
          return data!.isNotEmpty ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 6),
              shrinkWrap: true,
              itemCount: data![value.getFilterCatIndex].options!.length,
              itemBuilder: (context,index){
                return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(data[value.getFilterCatIndex].options![index].label.toString()),
                    value:  _isChecked[value.getFilterCatIndex][index], onChanged: (val){
                       setState(() {
                         for (int i=0;i<data![value.getFilterCatIndex].options!.length;i++) {
                           _isChecked[value.getFilterCatIndex][i] = false;
                           //valueList[value.getFilterCatIndex] = '';
                         }
                         _isChecked[value.getFilterCatIndex][index] = val!;
                         valueList[value.getFilterCatIndex] = data![value.getFilterCatIndex].options![index].value.toString();
                       });
                });
              }): Container(padding: const EdgeInsets.only(top: 10),child: const Text("No Data Found.."),);
        },
      );
    }

    Widget filterName(String name,int index){
      if(name == "Category"){
        return Container();
      }
      return  GestureDetector(
        onTap: (){
          context.read<ProductProvider>().setFilterCatIndex(index);
          debugPrint("list of bools >>>>> $_isChecked");
          debugPrint("list of values >>>>> $valueList");
        },
        child: Container(
          color: index == context.watch<ProductProvider>().getFilterCatIndex ?
          Colors.transparent : Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(name,style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.2),),
              ),
              Divider(height: 0,)
            ],
          ),
        ),
      );
    }

    Widget middleView(List<Aggregations>? data){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data!.map((e) => filterName(e.label!,data.indexOf(e))).toList(),
            ),
          ),
          Expanded(
              flex: 2,
              child: valueRow(data))
        ],
      );
    }

    return
   SingleChildScrollView(
     child: Column(
          children: [
            topView(widget.filterData),
            const Divider(height: 0,),
            middleView(widget.filterData),
            bottomView(widget.filterData)
          ],
      ),
   );
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _isChecked.clear();
  // }
}

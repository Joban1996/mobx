import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/provider/auth/login_provider.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/common_textfield_style.dart';
import '../../common_widgets/globally_common/app_bar_common.dart';
import '../../utils/constants/constants_colors.dart';
import '../../utils/constants/strings.dart';
import '../../utils/routes.dart';
import '../../utils/utilities.dart';



class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon(
        Text(Strings.search,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600)),
        appbar: AppBar(),
        onTapCallback: () {},
        leadingImage: Consumer<DashboardProvider>(
          builder: (_,val,child){
            return IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () { Navigator.pop(context);
              val.setSearchData(null);}
            );
          },

        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Consumer2<DashboardProvider,LoginProvider>(
          builder: (_,val1,val2,child){
            return Column(
              children: [
                TextField(
                  onChanged: (val){
                      if(_searchController.text.trim() == "") {
                        val1.setSearchData(null);
                      }else{
                    val2.setLoadingBool(true);
                    val1.hitSearchProductQuery(searchValue: _searchController.text.trim()).then((value) {
                      val2.setLoadingBool(false);
                    });}
                  },
                  controller: _searchController,
                  inputFormatters: [LengthLimitingTextInputFormatter(15),],
                  style: Theme.of(context).textTheme.bodyMedium,
                  keyboardType: TextInputType.text,
                  decoration: CommonStyle.textFieldStyle(context,isLeading: false,
                      hintText: "What you want to Purchase?",suffix: IconButton(onPressed: (){
                          val1.setSearchData(null);
                        _searchController.clear();
                      }, icon: Icon(Icons.close))),
                ),
                SizedBox(height: getCurrentScreenHeight(context)*0.03,),
                Expanded(
                  child: val1.getSearchData != null ? ListView.separated(itemBuilder: (context,index){
                    return GestureDetector(
                        onTap: (){
                          val1.setSkuId(val1.getSearchData!.products!.items![index].sku.toString());
                          Navigator.pushReplacementNamed(
                              context, Routes.productDetail1);
                          val1.setSearchData(null);
                        },
                        child: Container(
                            color: Colors.transparent,
                            child: Text(val1.getSearchData!.products!.items![index].name.toString(),style: Theme.of(context).textTheme.bodySmall,)));
                  }, separatorBuilder: (context,index){
                    return dividerCommon(context);
                  }, itemCount: val1.getSearchData!.products!.items!.length) : Container(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

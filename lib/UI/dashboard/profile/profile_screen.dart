import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mobx/common_widgets/dashboard/item_info_arrow_forward.dart';
import 'package:mobx/model/name_model.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../../api/graphql_operation/customer_queries.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/routes.dart';



class ProfileScreen extends StatefulWidget {
   ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '',email = '',mobile = '',dataOfBithN = '', lastName = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late VoidCallback reFresh;

  Widget accountInfo(BuildContext context, var profileData) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.accountInfo,style: Theme.of(context).textTheme.bodyText2,),
                verticalSpacing(heightInDouble: 0.01, context: context),
                Text("${profileData['firstname']} ${profileData['lastname']}",style: Theme.of(context).textTheme.caption),
                Text("+${profileData['mobilenumber']} / ${profileData['email']}",style: Theme.of(context).textTheme.caption,)
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.accountInformation,arguments: ProfileNames("${profileData['firstname']}","${profileData['lastname']}"));},
              child: Text("Edit",style: Theme.of(context).textTheme.caption!.copyWith(color: Utility.getColorFromHex(globalRedColor)),))
        ],
      ),
    );
  }

  Widget _row(String title,BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(title,
                style: Theme.of(context).textTheme.caption),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Utility.getColorFromHex(globalSubTextGreyColor),
            size: 20,
          )
        ],
      ),
    );
  }

  Widget _specialText(String title,String titleTwo,BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: RichText(text: TextSpan(
              text:title,
               style: Theme.of(context).textTheme.caption,
               children: <TextSpan>[
                TextSpan(
              text:titleTwo,
               style: TextStyle(
                fontSize: 12,
                color: Colors.blueAccent
               )

               )
               ]
            )),

          ),

          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Utility.getColorFromHex(globalSubTextGreyColor),
            size: 20,
          )
        ],
      ),
    );
  }

  Widget aboutAndLegal(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.aboutLegal,style: Theme.of(context).textTheme.bodyText2,),
          verticalSpacing(heightInDouble: 0.01, context: context),
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Routes.aboutUs);
              },
              child: _row("About Us",context)
          ),
          GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, Routes.termsAndConditions);
              },
              child: _row("Term & Conditions", context)),
          GestureDetector(
              onTap: ()=>  Navigator.pushNamed(context, Routes.privacyPolicy),
              child: _row("Privacy Policy", context)),
          GestureDetector(
              onTap: ()async{
             String userEmail = "support@mobex.in";
             String emailSubject ="Contact via Email";
             String body = "Respected Sir";

             final Uri params = Uri(
               scheme: 'mailto',
               path: 'support@mobex.in',
               query: emailSubject, //add subject and body here
             );

             var url = params.toString();

             String query = ''' mailto:$userEmail?'
             &subject=${Uri.encodeComponent(emailSubject)}
                &body=${Uri.encodeComponent(body)}''';

             if(await canLaunch(url)){
                  await launch(url);
             }else{
                  debugPrint("Unable to Launch Email.");
             }

              },
              child: _specialText("Support Email - ","support@mobex.in", context)),
          GestureDetector(
              onTap: ()async{
                String phoneNumber = "tel:+91 7676576765";
                if(await canLaunch(phoneNumber) ){
                    launch(phoneNumber);
                }else{
                  debugPrint("Not open call app.");
                }

              },
              child: _specialText("Customer Care Number - ","7676576765", context))
          // _row("Refund Policy", context)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBarCommon(Text("PROFILE",style:  Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600)),
        //   appbar: AppBar(), onTapCallback: (){},leadingImage: IconButton(
        //     padding: EdgeInsets.zero,
        //     constraints: BoxConstraints(),
        //     icon: Icon(Icons.arrow_back),color: Colors.black,onPressed: ()=>Navigator.pop(context),),),
        body:
        Query(
        options:
        QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(getUserDetails),),
    builder: (QueryResult result,
    {VoidCallback? refetch, FetchMore? fetchMore}) {
    reFresh = refetch!;
    debugPrint("cart exception >>> ${result.exception}");
    if (result.hasException) {
      if(result.exception!.graphqlErrors[0].extensions!['category'].toString() == "graphql-authorization"){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          App.localStorage.clear();
          Navigator.pushReplacementNamed(context, Routes.loginScreen);});
      }
    return Text(result.exception.toString());
    }
    if (result.isLoading) {
    return globalLoader();
    }
    debugPrint("get wishlist data >>> ${result.data}");
    return

        SingleChildScrollView(
          child: Container(
            color: Colors.white.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                accountInfo(context,result.data!['customer']),
                dividerCommon(context),
                ItemInfoArrowForward(onTap: (){
                  Navigator.pushNamed(context, Routes.wishListScreeen);
                }, title: "WISH LISTS", description: "Buy Later, Quick Buy, Delete Wish lists"),
                dividerCommon(context),
                ItemInfoArrowForward(onTap: (){
                  Navigator.pushNamed(context, Routes.profileAddressesScreen);
                }, title: "ADDRESSES", description: "Add, Edit & Delete Addresses"),
                dividerCommon(context),
                ItemInfoArrowForward(onTap: (){
                  //Navigator.pushNamed(context, Routes.wishListScreeen);
                }, title: "INSURANCES", description: "Purchase Insurance for products"),
                dividerCommon(context),
                aboutAndLegal(context),
                dividerCommon(context),
                ItemInfoArrowForward(onTap: (){
                  Navigator.pushNamed(context, Routes.faqScreen);
                }, title: "FAQs", description: "View all Frequency Asked Questions"),
                dividerCommon(context),
                Consumer<DashboardProvider>(
                  builder: (_,val,child){
                    return  ItemInfoArrowForward(onTap: () {
                      clearPrefs(val);
                      Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
                    }, title: "LOGOUT", description: "Logout From this Device");
                  },
                ),
                dividerCommon(context),
                Align(
                    alignment: Alignment.center,
                    child: Text("Version 1.12",style: Theme.of(context).textTheme.caption,))
              ],
            ),),
        );})
    );
  }
 Future clearPrefs(DashboardProvider val)async{
    val.setTabIndex(0);
   await App.localStorage.clear();
  }
}

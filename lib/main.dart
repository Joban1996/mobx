import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/services.dart';
import 'package:mobx/provider/dashboard/dashboard_provider.dart';
import 'package:mobx/provider/dashboard/product_provider.dart';
import 'package:mobx/utils/app.dart';
import 'package:mobx/utils/constants/constants_colors.dart';
import 'package:mobx/utils/routes.dart';
import 'package:mobx/utils/utilities.dart';
import 'package:provider/provider.dart';
import 'UI/auth/splash_screen.dart';
import 'api/client_provider.dart';
import 'provider/auth/login_provider.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  await App.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0x00FFFFFF), // transparent status bar
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
    ],
    child: GraphQLProvider(
      client: GraphQLClientAPI.client(),
      child: MaterialApp(
        onGenerateRoute: Routes.generatedRoute,
        initialRoute: Routes.splashScreen,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "Gotham",
            textTheme: TextTheme(
                bodyText2: TextStyle(fontSize: 14.0, color: Utility.getColorFromHex(globalBlackColor),fontWeight: FontWeight.w600),
                caption: TextStyle(fontSize: 12.0,color:  Utility.getColorFromHex(globalSubTextGreyColor),fontWeight: FontWeight.w400,height: 1.3)
            )
        ),
        home: SplashScreen(),
      ),
    ),

  ));
}
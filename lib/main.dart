import 'package:acc_test/constants/color_constant.dart';
import 'package:acc_test/utils/providers.dart';
import 'package:acc_test/view/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/navigations.dart';


void main() {
  runApp( MultiProvider(
      providers: providers,
      child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.black, // Set the background color
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Set the appbar background color
          iconTheme: IconThemeData(
            color: Colors.white, // Set the appbar icon color
          ),

        ),
        scaffoldBackgroundColor: Colors.black, // Set the scaffold background color
        primaryColorDark: Colors.white, // Set the primary dark color for buttons
        toggleableActiveColor: Colors.white, // Set the active color for toggleable elements
        iconTheme: IconThemeData(
          color: Colors.white, // Set the default icon color
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Colors.white, // Set the default text color
          ),
          bodyText1: TextStyle(
            color: ColorConstant.primaryThemeColor, // Set the default text color
          ),
          // Add other text styles as needed
        ),
        // Add other theme customizations as needed
      )
      ,
      home: const DashBoardView(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/component/customAppBar/theme_toggle_button_controller.dart';
import 'package:flutter_expense_tracker/component/customBottomNavigationButton/tab_switch_controller.dart';
import 'package:flutter_expense_tracker/controller/bar_screen_controller.dart';
import 'package:flutter_expense_tracker/controller/home_page_controller.dart';
import 'package:flutter_expense_tracker/core/AppColor/app_Color.dart';
import 'package:flutter_expense_tracker/expense_database/hive_intializer.dart';
import 'package:flutter_expense_tracker/view/bar_graph_screen/bar_screen.dart';
import 'package:flutter_expense_tracker/view/home_page/home_page.dart';
import 'package:flutter_expense_tracker/view/landing_page/landing_page_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitializer.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.secondaryLightColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColor.primaryLightColor,
    );
    final ThemeData darkTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.secondaryDarkColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColor.primaryDarkColor,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomepageController()),
        ChangeNotifierProvider(create: (context) => BarScreenController()),
        ChangeNotifierProvider(create: (context) => TabSwitchController()),
        ChangeNotifierProvider(
          create: (context) => ThemeToggleButtonController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: LandingPageScreen(),
      ),
    );
  }
}

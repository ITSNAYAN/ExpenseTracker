import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/component/customBottomNavigationButton/tab_switch_controller.dart';
import 'package:flutter_expense_tracker/controller/bar_screen_controller.dart';
import 'package:flutter_expense_tracker/controller/home_page_controller.dart';
import 'package:flutter_expense_tracker/expense_database/hive_intializer.dart';
import 'package:flutter_expense_tracker/view/bar_graph_screen/bar_screen.dart';
import 'package:flutter_expense_tracker/view/home_page.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomepageController()),
        ChangeNotifierProvider(create: (context) => BarScreenController()),
        ChangeNotifierProvider(create: (context) => TabSwitchController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffad853a), brightness: Brightness.light,),
           scaffoldBackgroundColor: Color(0xffdfde94),
        //  scaffoldBackgroundColor: Colors.yellow,

        ),
        home: LandingPageScreen(),
      ),
    );
  }
}

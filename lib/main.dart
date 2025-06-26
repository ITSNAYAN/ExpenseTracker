import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/bar_screen_controller.dart';
import 'package:flutter_expense_tracker/controller/home_page_controller.dart';
import 'package:flutter_expense_tracker/expense_database/hive_intializer.dart';
import 'package:flutter_expense_tracker/view/bar_graph_screen/bar_screen.dart';
import 'package:flutter_expense_tracker/view/home_page.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: BarScreen(),
      ),
    );
  }
}

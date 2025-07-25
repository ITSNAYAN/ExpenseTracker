import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/bar_screen_controller.dart';
import 'package:flutter_expense_tracker/controller/bar_screen_controller.dart';
import 'package:flutter_expense_tracker/controller/home_page_controller.dart';
import 'package:flutter_expense_tracker/core/AppColor/app_Color.dart';
import 'package:flutter_expense_tracker/core/component/customAppBar/language_change_button_controller.dart';
import 'package:flutter_expense_tracker/core/component/customAppBar/theme_toggle_button_controller.dart';
import 'package:flutter_expense_tracker/core/component/customBottomNavigationButton/scrollController.dart';
import 'package:flutter_expense_tracker/core/component/customBottomNavigationButton/tab_switch_controller.dart';
import 'package:flutter_expense_tracker/core/expense_database/hive_intializer.dart';
import 'package:flutter_expense_tracker/service/notificationService/notification_service.dart';
import 'package:flutter_expense_tracker/view/landing_page/landing_page_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/appLocalization/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await HiveInitializer.initHive();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeToggleButtonController(),
        ),
        ChangeNotifierProvider(create: (context) => LanguageChangeController()),
        ChangeNotifierProvider(create: (context) => ScrollAwareController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageChangeController = Provider.of<LanguageChangeController>(
      context,
    );
    final themeProvider = Provider.of<ThemeToggleButtonController>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomepageController()),
        ChangeNotifierProvider(create: (_) => BarScreenController()),
        ChangeNotifierProvider(create: (_) => TabSwitchController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        locale: languageChangeController.isEnglish
            ? Locale('en')
            : Locale('hi'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en', ''), Locale('hi', '')],
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        themeMode: themeProvider.currentTheme,
        darkTheme: MyTheme.darkTheme,
        home: LandingPageScreen(),
      ),
    );
  }
}

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.secondaryLightColor,
      primary: AppColor.primaryLightColor,
      secondary: AppColor.secondaryLightColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColor.primaryLightColor,
  );
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.secondaryDarkColor,
      primary: AppColor.primaryDarkColor,
      secondary: AppColor.secondaryDarkColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColor.primaryDarkColor,
  );
}

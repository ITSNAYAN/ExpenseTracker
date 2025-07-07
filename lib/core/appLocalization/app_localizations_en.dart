// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeScreenTitle => 'Your Expense';

  @override
  String get bottomNavigationText1 => 'Expense';

  @override
  String get bottomNavigationText2 => 'Analysis';

  @override
  String get analysisScreenTitle => 'Spend Analysis';
}

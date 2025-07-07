import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/core/appLocalization/app_localizations.dart';
import 'package:flutter_expense_tracker/core/component/customAppBar/language_change_button_controller.dart';
import 'package:flutter_expense_tracker/core/component/customAppBar/theme_toggle_button_controller.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String text;
  Widget? themeButton;

  CustomAppBar({required this.text, super.key, this.themeButton});

  @override
  Widget build(BuildContext context) {
    LanguageChangeController controller = Provider.of<LanguageChangeController>(context);
    return AppBar(
      centerTitle: true,
      title: Text(
        text,
        style: GoogleFonts.saira(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      actions: [controller.languageChangeButton(context)],
      leading: themeToggleButton(context),
    );
  }

  Widget themeToggleButton(BuildContext context) {
    ThemeToggleButtonController controller = Provider.of<ThemeToggleButtonController>(context);
    return IconButton(
      onPressed: () {
        controller.onSelectTheme();
      },
      icon: Icon(controller.isLightThemeSelect ? Icons.light_mode : Icons.dark_mode, color: Theme.of(context).colorScheme.secondary),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}

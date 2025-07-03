import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/component/customAppBar/theme_toggle_button_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String text;
  Widget? themeButton;

  CustomAppBar({required this.text, super.key, this.themeButton});

  @override
  Widget build(BuildContext context) {
    return
       AppBar(
         centerTitle: true,
        title: Text(
          text,
          style: GoogleFonts.saira(color: Color(0xff9b7734), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        leading: themeToggleButton(context),
      );

  }

  Widget themeToggleButton(BuildContext context) {
    ThemeToggleButtonController controller = Provider.of<ThemeToggleButtonController>(context);
    return IconButton(

      onPressed: () {
        controller.onSelectTheme();
      },
      icon:  Icon(controller.isThemeSelect? Icons.light_mode : Icons.dark_mode));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}

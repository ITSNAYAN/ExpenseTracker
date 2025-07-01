import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/component/custom_bottom_navigation_button.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(right: 12,left: 12,bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: CustomBottomNavigationButton()),
        ],
        ),
      ),
    );
  }
}

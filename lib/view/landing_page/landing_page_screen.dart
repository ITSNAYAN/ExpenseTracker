import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/core/component/customBottomNavigationButton/custom_bottom_navigation_button.dart';
import 'package:flutter_expense_tracker/core/component/customBottomNavigationButton/tab_switch_controller.dart';
import 'package:provider/provider.dart';

import '../bar_graph_screen/bar_screen.dart';
import '../home_page/home_page.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TabSwitchController>(
        builder: (context, tabController, child) {
          return Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 30),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                tabController.selectExpenseValue ? const HomePage() : const BarScreen(),
                Padding(padding: const EdgeInsets.only(right: 12, left: 12, bottom: 50), child: const CustomBottomNavigationButton()),
              ],
            ),
          );
        },
      ),
    );
  }
}

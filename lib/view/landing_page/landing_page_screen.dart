import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/core/component/customBottomNavigationButton/custom_bottom_navigation_button.dart';
import 'package:flutter_expense_tracker/core/component/customBottomNavigationButton/scrollController.dart';
import 'package:flutter_expense_tracker/core/component/customBottomNavigationButton/tab_switch_controller.dart';
import 'package:provider/provider.dart';

import '../bar_graph_screen/bar_screen.dart';
import '../home_page/home_page.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({super.key});

  @override
  State<LandingPageScreen> createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  double _previousOffset = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      print(offset);
      context.read<ScrollAwareController>().updateVisibility(offset);
     // Provider.of<ScrollAwareController>(context, listen: false).updateVisibility(offset);
    });
    super.initState();
  }

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
                tabController.selectExpenseValue ? HomePage(scrollController: _scrollController) : BarScreen(scrollController: _scrollController),
                // Consumer<ScrollAwareController>(
                //   builder: (context, value, child) {
                //     print("~~~~~~~~~~~~~"+value.isVisible.toString());
                //     return AnimatedSlide(
                //       offset: value.isVisible ? Offset(0, 0) : Offset(0, 1.5),
                //       duration: Duration(milliseconds: 250),
                //       child: child,
                //     );
                //   },
                //   child: Padding(padding: const EdgeInsets.only(right: 12, left: 12, bottom: 50), child: const CustomBottomNavigationButton()),
                // ),
               AnimatedSlide(
                      offset: context.watch<ScrollAwareController>().isVisible ? Offset(0, 0) : Offset(0, 1.5),
                      duration: Duration(milliseconds: 250),
                      child: Padding(padding: const EdgeInsets.only(right: 12, left: 12, bottom: 50), child: const CustomBottomNavigationButton()),
                    ),

              ],
            ),
          );
        },
      ),
    );
  }
}

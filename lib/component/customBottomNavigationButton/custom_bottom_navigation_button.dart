import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/component/customBottomNavigationButton/tab_switch_controller.dart';
import 'package:flutter_expense_tracker/expense_database/expense_adapter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationButton extends StatelessWidget {
  const CustomBottomNavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final tabSwitchController = Provider.of<TabSwitchController>(context);
    return Container(
      height: 50,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Sliding background
          AnimatedAlign(
            alignment: tabSwitchController.selectExpenseValue
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: 85,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color:Theme.of(context).colorScheme.secondary,
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: const SizedBox(), // Glassy blur
                ),
              ),
            ),
          ),

          // Tappable Tabs
          Row(
            children: [
              _buildTab(
                context,
                "Expense",
                tabSwitchController.selectExpenseValue,
                tabSwitchController.onTapExpense,
              ),
              _buildTab(
                context,
                "Analysis",
                !tabSwitchController.selectExpenseValue,
                tabSwitchController.onTapAnalysis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
      BuildContext context,
      String text,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child,animation){
              return FadeTransition(opacity: animation,
                child: TweenAnimationBuilder(tween: Tween<double>(begin: 4.0,end: 0.0 ), duration: Duration(milliseconds: 300), builder: (context,sigma,_){
                  return ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: sigma,sigmaY: sigma),
                  child: child,);
                }),
              );
            },
            child: Text(
              text,
              key: ValueKey(isSelected),
              style: GoogleFonts.saira(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

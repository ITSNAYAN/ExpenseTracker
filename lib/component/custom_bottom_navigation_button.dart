import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationButton extends StatefulWidget {
  const CustomBottomNavigationButton({super.key});

  @override
  State<CustomBottomNavigationButton> createState() =>
      _CustomBottomNavigationButtonState();
}

class _CustomBottomNavigationButtonState
    extends State<CustomBottomNavigationButton> {
  bool isExpenseSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Sliding Glassy Effect
          AnimatedAlign(
            alignment: isExpenseSelected
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
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: const SizedBox(), // Glass effect only
                ),
              ),
            ),
          ),

          // Static Text Labels with Tap
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(text: "Expense", isSelected: isExpenseSelected, onTap: () {
                setState(() => isExpenseSelected = true);
              }),
              _buildTab(text: "Analysis", isSelected: !isExpenseSelected, onTap: () {
                setState(() => isExpenseSelected = false);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child:isSelected? Text(
            text,
            style: GoogleFonts.saira(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ):Text(
            text,
            style: GoogleFonts.saira(
              fontSize: 14,
               fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}

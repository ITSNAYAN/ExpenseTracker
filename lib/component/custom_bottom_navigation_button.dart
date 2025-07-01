import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationButton extends StatelessWidget {
  const CustomBottomNavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return
       Container (
        height: 50,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildNavigationText("Expense"),
              Text("Analysis"),
            ],
          ),
        ),
      );
    }

  Container buildNavigationText(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!, width: 1),
        color: Colors.grey[100]!, // Semi-transparent background
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.saira(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  }


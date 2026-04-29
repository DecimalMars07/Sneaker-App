import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.onTabChange});

  final void Function(int) onTabChange;

  @override
  Widget build(BuildContext context) {
    // Grab screen dimensions to make everything proportional
    final size = MediaQuery.sizeOf(context);
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Container(
      color: Colors.teal,
      // Proportional vertical spacing from the bottom edge
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      child: GNav(
        mainAxisAlignment: MainAxisAlignment.center,

        // 1. Color of the UNSELECTED icons
        color: Colors.teal[100],

        // 2. Color of the SELECTED text & icon
        activeColor: Colors.teal[800],

        // 3. Background color of the selected pill
        tabBackgroundColor: Colors.white,

        // Responsive gap between icon and text
        gap: screenWidth * 0.02,

        // Ensure the icons scale properly
        iconSize: screenWidth * 0.065,

        // Ensure the text scales properly
        textStyle: TextStyle(
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.w600,
          color: Colors.teal[800],
        ),

        // Connect the function (simplified syntax!)
        onTabChange: onTabChange,

        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Shop',
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06, // Responsive pill width
              vertical: screenHeight * 0.018, // Responsive pill height
            ),
          ),
          GButton(
            icon: Icons.shopping_bag_rounded,
            text: 'Cart',
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.018,
            ),
          ),
        ],
      ),
    );
  }
}
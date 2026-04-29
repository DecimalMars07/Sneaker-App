import 'package:flutter/material.dart';
import 'package:sneaker_app/features/shop/services/firbase_auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade200,
      child: Column(
        children: [
          SizedBox(height: 65),
          DrawerHeader(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.transparent)),
            ),
            child: Icon(
              Icons.shopping_bag,
              size: 90,
              color: Colors.teal.shade800,
            ),
          ),
          SizedBox(height: 85),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 50),
            child: ListTile(
              leading: Icon(Icons.home, color: Colors.teal.shade800, size: 30),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.teal.shade800, fontSize: 26),
              ),
              onTap: () {
                // Close the drawer
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 50),
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.teal.shade800, size: 30),
              title: Text(
                'About',
                style: TextStyle(color: Colors.teal.shade800, fontSize: 26),
              ),
              onTap: () {
                // Close the drawer
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 50),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.teal.shade800,
                size: 30,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.teal.shade800, fontSize: 26),
              ),
              onTap: () {
                FirebaseAuthService().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}

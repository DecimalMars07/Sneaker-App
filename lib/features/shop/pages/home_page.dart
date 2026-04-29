import 'package:flutter/material.dart';
import 'package:sneaker_app/core/widgets/bottom_nav_bar.dart';
import 'package:sneaker_app/core/widgets/my_drawer.dart';
import 'package:sneaker_app/features/cart/pages/cart_page.dart';
import 'package:sneaker_app/features/shop/pages/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> pages = const [ShopPage(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(onTabChange: navigateBottomBar),
    );
  }
}

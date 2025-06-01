import 'package:flutter/material.dart';
import 'package:jewelme_application/view/Explore_page.dart';
import 'package:jewelme_application/view/cart_page.dart';
import 'package:jewelme_application/view/home_page.dart';
import 'package:jewelme_application/view/profile_page.dart';
import 'package:jewelme_application/view/wishlist_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  List<Widget> listBottomScreen=[
    const HomePage(),
    const ExplorePage(),
    const WishlistPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Color(0xFFFFFCF4),
        type: BottomNavigationBarType.fixed,
        selectedItemColor:  Color(0xFFD9534F),
        unselectedItemColor: Colors.grey,
        
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: '',),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
    ),
    );
  }
}

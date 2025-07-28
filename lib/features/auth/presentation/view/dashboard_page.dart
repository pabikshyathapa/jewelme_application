import 'package:flutter/material.dart';
import 'package:jewelme_application/features/cart/presentation/view/cart_page.dart';
import 'package:jewelme_application/features/home/presentation/view/home_page.dart';
import 'package:jewelme_application/features/profile/presenttaion/view/profile_page.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view/wishlist_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  List<Widget> listBottomScreen=[
    const HomeViewPage(),
    const WishlistViewPage(),
    const CartViewPage(),
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
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: '',),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
    ),
    );
  }
}

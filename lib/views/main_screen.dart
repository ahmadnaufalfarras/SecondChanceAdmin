import 'package:flutter/material.dart';
import 'package:second_chance_admin/views/buyer_screen.dart';
import 'package:second_chance_admin/views/categories_screen.dart';
import 'package:second_chance_admin/views/dashboard_screen.dart';
import 'package:second_chance_admin/views/order_screen.dart';
import 'package:second_chance_admin/views/products_screen.dart';
import 'package:second_chance_admin/views/upload_banner_screen.dart';
import 'package:second_chance_admin/views/vendor_screen.dart';
import 'package:second_chance_admin/views/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    BuyerScreen(),
    VendorScreen(),
    WithdrawalScreen(),
    OrderScreen(),
    CategoriesScreen(),
    ProductScreen(),
    UploadBannerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.selected,
            backgroundColor: Colors.white,
            elevation: 5,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Buyers'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.store),
                label: Text('Vendors'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.attach_money),
                label: Text('Withdrawal'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart),
                label: Text('Orders'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.category),
                label: Text('Categories'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inventory_2),
                label: Text('Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.flag),
                label: Text('Banners'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:second_chance_admin/views/categories_screen.dart';
import 'package:second_chance_admin/views/dashboard_screen.dart';
import 'package:second_chance_admin/views/order_screen.dart';
import 'package:second_chance_admin/views/products_screen.dart';
import 'package:second_chance_admin/views/upload_banner_screen.dart';
import 'package:second_chance_admin/views/vendor_screen.dart';
import 'package:second_chance_admin/views/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();

  Map<String, Widget> screens = {
    DashboardScreen.routeName: DashboardScreen(),
    VendorScreen.routeName: VendorScreen(),
    WithdrawalScreen.routeName: WithdrawalScreen(),
    OrderScreen.routeName: OrderScreen(),
    CategoriesScreen.routeName: CategoriesScreen(),
    ProductScreen.routeName: ProductScreen(),
    UploadBannerScreen.routeName: UploadBannerScreen(),
  };

  void screenSelector(item) {
    setState(() {
      _selectedItem = screens[item.route]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          title: const Text(
            'Second Chance Admin',
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                tileMode: TileMode.mirror,
                colors: [
                  Color(0xFF161A1D),
                  Color(0xFFB80C09),
                ],
              ),
            ),
          ),
          elevation: 0,
          centerTitle: false,
        ),
        sideBar: SideBar(
          // activeBackgroundColor: c,
          items: [
            AdminMenuItem(
              title: 'Dashboard',
              icon: Icons.dashboard,
              route: DashboardScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Vendors',
              icon: CupertinoIcons.person_3,
              route: VendorScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Withdrawal',
              icon: CupertinoIcons.money_dollar,
              route: WithdrawalScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Orders',
              icon: CupertinoIcons.shopping_cart,
              route: OrderScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Categories',
              icon: Icons.category,
              route: CategoriesScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Products',
              icon: Icons.shop,
              route: ProductScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Upload Banners',
              icon: CupertinoIcons.add,
              route: UploadBannerScreen.routeName,
            )
          ],
          selectedRoute: '',
          onSelected: (item) {
            screenSelector(item);
          },
        ),
        body: _selectedItem);
  }
}

import 'package:flutter/material.dart';
import 'package:second_chance_admin/views/categories_screen.dart';
import 'package:second_chance_admin/views/dashboard_screen.dart';
import 'package:second_chance_admin/views/order_screen.dart';
import 'package:second_chance_admin/views/products_screen.dart';
import 'package:second_chance_admin/views/upload_banner_screen.dart';
import 'package:second_chance_admin/views/vendor_screen.dart';
import 'package:second_chance_admin/views/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '\MainScreen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isExpanded = false;

  int selectedIndex = 0;
  final List<Widget> pages = [
    DashboardScreen(),
    VendorScreen(),
    WithdrawalScreen(),
    OrderScreen(),
    CategoriesScreen(),
    ProductScreen(),
    UploadBannerScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
              extended: isExpanded,
              backgroundColor: Colors.deepPurple.shade400,
              unselectedIconTheme:
                  IconThemeData(color: Colors.white, opacity: 1),
              unselectedLabelTextStyle: TextStyle(color: Colors.white),
              selectedIconTheme:
                  IconThemeData(color: Colors.deepPurple.shade900),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text("Dashboard"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.store),
                  label: Text("Vendor"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.money),
                  label: Text("Withdrawal"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_bag),
                  label: Text("Order"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.category),
                  label: Text("Categories"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.inventory_2),
                  label: Text("Product"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text("Banners"),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pages[index]),
                );
              }),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(60.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: Icon(Icons.menu),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1482779317240-1e0abab50387?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=ce71d7531849779c0a87f8652b647796"),
                          radius: 26.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:second_chance_admin/views/categories_screen.dart';
// import 'package:second_chance_admin/views/dashboard_screen.dart';
// import 'package:second_chance_admin/views/order_screen.dart';
// import 'package:second_chance_admin/views/products_screen.dart';
// import 'package:second_chance_admin/views/upload_banner_screen.dart';
// import 'package:second_chance_admin/views/vendor_screen.dart';
// import 'package:second_chance_admin/views/withdrawal_screen.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   Widget _selectedItem = DashboardScreen();

//   screenSelector(item) {
//     switch (item.route) {
//       case DashboardScreen.routeName:
//         setState(() {
//           _selectedItem = DashboardScreen();
//         });

//         break;

//       case VendorScreen.routeName:
//         setState(() {
//           _selectedItem = VendorScreen();
//         });

//         break;

//       case WithdrawalScreen.routeName:
//         setState(() {
//           _selectedItem = WithdrawalScreen();
//         });

//         break;

//       case OrderScreen.routeName:
//         setState(() {
//           _selectedItem = OrderScreen();
//         });

//         break;

//       case CategoriesScreen.routeName:
//         setState(() {
//           _selectedItem = CategoriesScreen();
//         });

//         break;

//       case ProductScreen.routeName:
//         setState(() {
//           _selectedItem = ProductScreen();
//         });

//         break;

//       case UploadBannerScreen.routeName:
//         setState(() {
//           _selectedItem = UploadBannerScreen();
//         });

//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AdminScaffold(
//         backgroundColor: Colors.white,
//         sideBar: SideBar(
//           items: [
//             AdminMenuItem(
//               title: 'Dashboard',
//               icon: Icons.dashboard,
//               route: DashboardScreen.routeName,
//             ),
//             AdminMenuItem(
//               title: 'Vendors',
//               icon: CupertinoIcons.person_3,
//               route: VendorScreen.routeName,
//             ),
//             AdminMenuItem(
//               title: 'Withdrawal',
//               icon: CupertinoIcons.money_dollar,
//               route: WithdrawalScreen.routeName,
//             ),
//             AdminMenuItem(
//               title: 'Orders',
//               icon: CupertinoIcons.shopping_cart,
//               route: OrderScreen.routeName,
//             ),
//             AdminMenuItem(
//               title: 'Categories',
//               icon: Icons.category,
//               route: CategoriesScreen.routeName,
//             ),
//             AdminMenuItem(
//               title: 'Products',
//               icon: Icons.shop,
//               route: ProductScreen.routeName,
//             ),
//             AdminMenuItem(
//               title: 'Upload Banners',
//               icon: CupertinoIcons.add,
//               route: UploadBannerScreen.routeName,
//             )
//           ],
//           selectedRoute: '',
//           onSelected: (item) {
//             screenSelector(item);
//           },
//           header: Container(
//             height: 50,
//             width: double.infinity,
//             color: const Color(0xff444444),
//             child: const Center(
//               child: Text(
//                 'Second Chance Management',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           footer: Container(
//             height: 50,
//             width: double.infinity,
//             color: const Color(0xff444444),
//             child: const Center(
//               child: Text(
//                 'footer',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: _selectedItem);
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_chance_admin/utils/build_cards.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '\DashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int vendorCount = 0;
  int buyerCount = 0;
  int orderCount = 0;
  int productCount = 0;
  int bannerCount = 0;
  int categoryCount = 0;

  @override
  void initState() {
    super.initState();
    fetchDataCounts();
  }

  Future<void> fetchDataCounts() async {
    try {
      QuerySnapshot vendorSnapshot =
          await FirebaseFirestore.instance.collection('vendors').get();
      vendorCount = vendorSnapshot.docs.length;

      QuerySnapshot buyerSnapshot =
          await FirebaseFirestore.instance.collection('buyers').get();
      buyerCount = buyerSnapshot.docs.length;

      QuerySnapshot orderSnapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      orderCount = orderSnapshot.docs.length;

      QuerySnapshot productSnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      productCount = productSnapshot.docs.length;

      QuerySnapshot bannerSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();
      bannerCount = bannerSnapshot.docs.length;

      QuerySnapshot categorySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      categoryCount = categorySnapshot.docs.length;

      // Memperbarui state untuk memicu pembaruan UI
      setState(() {});
    } catch (error) {
      Text('Terjadi kesalahan saat mengambil data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    children: [
                      buildCard(
                          Icons.store, Colors.black, 'Vendor', vendorCount),
                      buildCard(Icons.person, Colors.red, 'Buyer', buyerCount),
                      buildCard(Icons.inventory_2, Colors.blue, 'Product',
                          productCount),
                      buildCard(Icons.shopping_cart, Colors.green, 'Order',
                          orderCount),
                      buildCard(
                          Icons.flag, Colors.purple, 'Banner', bannerCount),
                      buildCard(Icons.category, Colors.yellow.shade600,
                          'Category', categoryCount),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

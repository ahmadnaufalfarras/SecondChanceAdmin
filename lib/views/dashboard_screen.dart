import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_chance_admin/utils/build_cards.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '\DashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _vendorCount = 0;
  int _buyerCount = 0;
  int _orderCount = 0;
  int _productCount = 0;
  int _bannerCount = 0;
  int _categoryCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchDataCounts();
  }

  Future<void> _fetchDataCounts() async {
    try {
      QuerySnapshot vendorSnapshot =
          await FirebaseFirestore.instance.collection('vendors').get();
      _vendorCount = vendorSnapshot.docs.length;

      QuerySnapshot buyerSnapshot =
          await FirebaseFirestore.instance.collection('buyers').get();
      _buyerCount = buyerSnapshot.docs.length;

      QuerySnapshot orderSnapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      _orderCount = orderSnapshot.docs.length;

      QuerySnapshot productSnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      _productCount = productSnapshot.docs.length;

      QuerySnapshot bannerSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();
      _bannerCount = bannerSnapshot.docs.length;

      QuerySnapshot categorySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      _categoryCount = categorySnapshot.docs.length;

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
                          Icons.store, Colors.black, 'Vendor', _vendorCount),
                      buildCard(Icons.person, Colors.red, 'Buyer', _buyerCount),
                      buildCard(Icons.inventory_2, Colors.blue, 'Product',
                          _productCount),
                      buildCard(Icons.shopping_cart, Colors.green, 'Order',
                          _orderCount),
                      buildCard(
                          Icons.flag, Colors.purple, 'Banner', _bannerCount),
                      buildCard(Icons.category, Colors.yellow.shade600,
                          'Category', _categoryCount),
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

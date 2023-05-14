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

      // Memperbarui state untuk memicu pembaruan UI
      setState(() {});
    } catch (error) {
      print('Terjadi kesalahan saat mengambil data: $error');
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
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 3.0,
                  children: [
                    buildCard(Icons.store, Colors.black, 'Vendor', vendorCount),
                    buildCard(Icons.person, Colors.red, 'Buyer', buyerCount),
                    buildCard(Icons.inventory_2, Colors.blue, 'Product',
                        productCount),
                    buildCard(
                        Icons.shopping_cart, Colors.green, 'Order', orderCount),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

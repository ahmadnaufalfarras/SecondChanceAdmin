import 'package:flutter/material.dart';
import 'package:second_chance_admin/models/dashboard_model.dart';
import 'package:second_chance_admin/utils/build_cards.dart';
import '../controllers/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '\DashboardScreen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardDataModel _dashboardData = DashboardDataModel();
  DashboardController _controller = DashboardController();

  @override
  void initState() {
    super.initState();
    _fetchDataCounts();
  }

  Future<void> _fetchDataCounts() async {
    await _controller.getDataCounts();
    setState(() {
      _dashboardData = _controller.dashboardDataModel;
    });
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
                      buildCard(Icons.store, Colors.black, 'Vendor',
                          _dashboardData.vendorCount),
                      buildCard(Icons.person, Colors.red, 'Buyer',
                          _dashboardData.buyerCount),
                      buildCard(Icons.inventory_2, Colors.blue, 'Product',
                          _dashboardData.productCount),
                      buildCard(Icons.shopping_cart, Colors.green, 'Order',
                          _dashboardData.orderCount),
                      buildCard(Icons.flag, Colors.purple, 'Banner',
                          _dashboardData.bannerCount),
                      buildCard(Icons.category, Colors.yellow.shade600,
                          'Category', _dashboardData.categoryCount),
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

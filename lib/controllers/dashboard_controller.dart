import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dashboard_model.dart';

class DashboardController {
  DashboardDataModel dashboardDataModel = DashboardDataModel();

  Future<void> getDataCounts() async {
    try {
      QuerySnapshot vendorSnapshot =
          await FirebaseFirestore.instance.collection('vendors').get();
      dashboardDataModel.vendorCount = vendorSnapshot.docs.length;

      QuerySnapshot buyerSnapshot =
          await FirebaseFirestore.instance.collection('buyers').get();
      dashboardDataModel.buyerCount = buyerSnapshot.docs.length;

      QuerySnapshot orderSnapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      dashboardDataModel.orderCount = orderSnapshot.docs.length;

      QuerySnapshot productSnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      dashboardDataModel.productCount = productSnapshot.docs.length;

      QuerySnapshot bannerSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();
      dashboardDataModel.bannerCount = bannerSnapshot.docs.length;

      QuerySnapshot categorySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      dashboardDataModel.categoryCount = categorySnapshot.docs.length;
    } catch (error) {
      print('Terjadi kesalahan saat mengambil data: $error');
    }
  }
}

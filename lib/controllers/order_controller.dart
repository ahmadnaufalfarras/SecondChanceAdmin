import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_chance_admin/models/order_model.dart';

class OrderController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<OrderDataModel>> getOrderData() {
    return _firestore.collection('orders').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => OrderDataModel.fromMap(doc.data()))
              .toList(),
        );
  }
}

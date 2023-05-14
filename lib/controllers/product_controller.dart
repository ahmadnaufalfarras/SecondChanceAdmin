import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_chance_admin/models/product_model.dart';

class ProductController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ProductDataModel>> getProductData() {
    return _firestore.collection('products').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => ProductDataModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> approveProduct(String productId) async {
    await _firestore.collection('products').doc(productId).update({
      'approved': true,
    });
  }

  Future<void> rejectProduct(String productId) async {
    await _firestore.collection('products').doc(productId).update({
      'approved': false,
    });
  }
}

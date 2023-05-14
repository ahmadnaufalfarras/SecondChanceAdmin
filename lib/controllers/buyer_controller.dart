import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_chance_admin/models/buyer_model.dart';

class BuyerController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<BuyerDataModel>> getBuyerData() {
    return _firestore.collection('buyers').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => BuyerDataModel.fromMap(doc.data()))
              .toList(),
        );
  }
}

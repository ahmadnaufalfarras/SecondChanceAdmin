import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_chance_admin/models/withdrawal_model.dart';

class WithdrawalController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<WithdrawalDataModel>> getWithdrawalData() {
    return _firestore.collection('withdrawal').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => WithdrawalDataModel.fromMap(doc.data()))
              .toList(),
        );
  }
}

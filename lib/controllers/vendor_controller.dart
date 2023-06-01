import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_chance_admin/models/vendor_model.dart';

class VendorBankController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<VendorDataModel>> getVendorData() {
    return _firestore.collection('vendors').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => VendorDataModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> approveVendor(String vendorId) async {
    await _firestore.collection('vendors').doc(vendorId).update({
      'approved': true,
    });
  }

  Future<void> rejectVendor(String vendorId) async {
    await _firestore.collection('vendors').doc(vendorId).update({
      'approved': false,
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_chance_admin/models/vendor_model.dart';
import 'package:second_chance_admin/utils/show_dialog.dart';

class VendorController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<VendorDataModel>> getVendorData() {
    return _firestore.collection('vendors').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => VendorDataModel.fromMap(doc.data()))
              .toList(),
        );
  }

  Future<void> approveVendor(String vendorId, BuildContext context) async {
    EasyLoading.show();
    await _firestore.collection('vendors').doc(vendorId).update({
      'approved': true,
    });
    await EasyLoading.dismiss();
    displayDialog(
      context,
      'Vendor has been approved',
      Icon(
        Icons.check_circle_rounded,
        color: Colors.green.shade600,
        size: 60,
      ),
    );
  }

  Future<void> rejectVendor(String vendorId, BuildContext context) async {
    EasyLoading.show();
    await _firestore.collection('vendors').doc(vendorId).update({
      'approved': false,
    });
    await EasyLoading.dismiss();
    displayDialog(
      context,
      'Vendor has been rejected',
      Icon(
        Icons.cancel,
        color: Colors.red.shade600,
        size: 60,
      ),
    );
  }
}

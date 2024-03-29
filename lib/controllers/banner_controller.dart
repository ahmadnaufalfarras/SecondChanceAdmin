import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_chance_admin/models/banner_model.dart';
import 'package:second_chance_admin/services/firebase_storage_service.dart';
import 'package:second_chance_admin/utils/refresh_page.dart';
import 'package:second_chance_admin/utils/show_dialog.dart';
import 'package:uuid/uuid.dart';

class BannerController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final TextEditingController fileNameController = TextEditingController();

  Uint8List? image;
  String bannerId = Uuid().v4();

  Function(Uint8List?)? onImageSelected;

  Stream<List<BannerDataModel>> getBannerData() {
    return _firestore.collection('banners').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => BannerDataModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> pickBannerImage() async {
    final result = await _firebaseStorageService.pickImage();
    if (result != null) {
      image = result;
      if (onImageSelected != null) {
        onImageSelected!(result);
      }
    }
  }

  Future<String?> uploadBannerToStorage() async {
    String? imageUrl;
    if (image != null) {
      imageUrl = await _firebaseStorageService.uploadImageFileToStorage(
          image!, 'banners', bannerId);
    }
    return imageUrl;
  }

  Future<void> uploadBanner(BuildContext context) async {
    EasyLoading.show();
    final imageUrl = await uploadBannerToStorage();
    if (imageUrl != null) {
      final banner = BannerDataModel(bannerId: bannerId, image: imageUrl);
      await _firestore
          .collection('banners')
          .doc(bannerId)
          .set(banner.toJson())
          .whenComplete(() {
        bannerId = Uuid().v4();
        EasyLoading.dismiss();
        refreshPage(context);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Banner uploaded successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload banner.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> deleteBanner(String bannerId, BuildContext context) async {
    try {
      EasyLoading.show();
      await _firestore.collection('banners').doc(bannerId).delete();
      await EasyLoading.dismiss();
      Navigator.of(context).pop();
      displayDialog(
        context,
        'Banner has been deleted successfully',
        Icon(
          Icons.delete,
          color: Colors.red.shade600,
          size: 60,
        ),
      );
    } catch (error) {
      Text('Failed to delete banner: $error');
    }
  }
}

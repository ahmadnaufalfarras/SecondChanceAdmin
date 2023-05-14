import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_chance_admin/models/banner_model.dart';
import 'package:second_chance_admin/services/firebase_storage_service.dart';
import 'package:uuid/uuid.dart';

class BannerController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final TextEditingController fileNameController = TextEditingController();

  Uint8List? image;
  String fileName = Uuid().v4();

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
      final fileName = Uuid().v4();
      imageUrl = await _firebaseStorageService.uploadImageFileToStorage(
          image!, 'banners', fileName);
    }
    return imageUrl;
  }

  Future<void> uploadBanner(BuildContext context) async {
    EasyLoading.show();
    final imageUrl = await uploadBannerToStorage();
    if (imageUrl != null) {
      final banner = BannerDataModel(image: imageUrl);
      await _firestore
          .collection('banners')
          .doc(fileName)
          .set(banner.toJson())
          .whenComplete(() {
        fileName = Uuid().v4();
        EasyLoading.dismiss();
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
}

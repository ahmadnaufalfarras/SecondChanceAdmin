import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_chance_admin/models/category_model.dart';
import 'package:second_chance_admin/services/firebase_storage_service.dart';
import 'package:second_chance_admin/utils/refresh_page.dart';
import 'package:uuid/uuid.dart';

class CategoryController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final TextEditingController fileNameController = TextEditingController();

  Uint8List? image;
  String fileName = Uuid().v4();

  Function(Uint8List?)? onImageSelected;

  Stream<List<CategoryDataModel>> getCategoryData() {
    return _firestore.collection('categories').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => CategoryDataModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> pickCategoryImage() async {
    final result = await _firebaseStorageService.pickImage();
    if (result != null) {
      image = result;
      if (onImageSelected != null) {
        onImageSelected!(result);
      }
    }
  }

  Future<String?> uploadCategoryToStorage() async {
    String? imageUrl;
    if (image != null) {
      final fileName = Uuid().v4();
      imageUrl = await _firebaseStorageService
          .uploadImageFileToStorage(image!, 'categoryImages', fileName)
          .whenComplete(() => imageUrl = null);
    }
    return imageUrl;
  }

  Future<void> uploadCategory(BuildContext context, String categoryName,
      GlobalKey<FormState> _formKey) async {
    EasyLoading.show();
    var imageUrl = await uploadCategoryToStorage();
    if (imageUrl != null) {
      final category =
          CategoryDataModel(image: imageUrl, categoryName: categoryName);
      await _firestore
          .collection('categories')
          .doc(fileName)
          .set(category.toJson())
          .whenComplete(() {
        _formKey.currentState!.reset();
        fileName = Uuid().v4();
        imageUrl = null;
        EasyLoading.dismiss();
        refreshPage(context);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Category uploaded successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload category.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/category_controller.dart';
import 'package:second_chance_admin/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '\CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoryController _categoryController = CategoryController();

  Uint8List? _selectedImage;
  String? categoryName;

  @override
  void initState() {
    super.initState();
    _categoryController.onImageSelected = (image) {
      setState(() {
        _selectedImage = image;
      });
    };
  }

  @override
  void dispose() {
    _categoryController.onImageSelected = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: const Text(
                'Select an Categories Image to Upload',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _selectedImage != null
                            ? Image.memory(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Text(
                                  'No image selected',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _categoryController.pickCategoryImage();
                          },
                          child: Text('Upload Image'))
                    ],
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      onChanged: (value) {
                        categoryName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Category Name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter Category Name',
                          hintText: 'Enter Category Name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _categoryController
                          .uploadCategory(context, categoryName!, _formKey)
                          .then((value) {
                        setState(() {
                          _selectedImage = null;
                          categoryName = null;
                        });
                      });
                    }
                  },
                  child: Text('Save'),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Uploaded Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}

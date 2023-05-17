import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/banner_controller.dart';
import 'package:second_chance_admin/widgets/banner_widget.dart';

class UploadBannerScreen extends StatefulWidget {
  static const String routeName = '\UploadBannerScreen';

  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final BannerController _bannerController = BannerController();

  Uint8List? _selectedImage;

  @override
  void initState() {
    super.initState();
    _bannerController.onImageSelected = (image) {
      setState(() {
        _selectedImage = image;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                'Select an Banner Image to Upload',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  image: _selectedImage == null
                      ? null
                      : DecorationImage(
                          image: MemoryImage(_selectedImage!),
                          fit: BoxFit.cover,
                        ),
                ),
                child: _selectedImage == null
                    ? Center(
                        child: Text(
                          'No image selected',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _bannerController.pickBannerImage();
                    },
                    child: Text('Upload Image'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _bannerController.uploadBanner(context).then((value) {
                        setState(() {
                          _selectedImage = null;
                        });
                      });
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Uploaded Banners',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BannerWidget(),
          ],
        ),
      ),
    );
  }
}

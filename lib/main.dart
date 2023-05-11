import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_chance_admin/views/dashboard_screen.dart';
import 'package:second_chance_admin/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyA6yyEBM8-iIHIMfp96LdzC-yypisLqdkA",
              appId: "1:313101163471:web:67e57e6a1b3c44f053d0ba",
              messagingSenderId: "313101163471",
              projectId: "second-chance-thrift-apps",
              storageBucket: "second-chance-thrift-apps.appspot.com",
            )
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}

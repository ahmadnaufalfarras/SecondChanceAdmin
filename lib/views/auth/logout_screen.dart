import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_chance_admin/views/auth/login_screen.dart';

class AdminLogoutScreen extends StatefulWidget {
  const AdminLogoutScreen({super.key});

  @override
  State<AdminLogoutScreen> createState() => _AdminLogoutScreenState();
}

class _AdminLogoutScreenState extends State<AdminLogoutScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            EasyLoading.show(status: 'Logging out');

            await _auth.signOut().whenComplete(
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AdminLoginScreen();
                    },
                  ),
                );

                EasyLoading.dismiss();
              },
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}

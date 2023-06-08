import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:second_chance_admin/authentication_wrapper.dart';
import 'package:second_chance_admin/controllers/auth_controller.dart';

class AdminLogoutScreen extends StatefulWidget {
  const AdminLogoutScreen({super.key});

  @override
  State<AdminLogoutScreen> createState() => _AdminLogoutScreenState();
}

class _AdminLogoutScreenState extends State<AdminLogoutScreen> {
  final AuthController _controller = AuthController();

  Future<void> _handleLogoutUsers() async {
    EasyLoading.show(status: 'Logging out');

    await _controller.logoutUsers().whenComplete(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return AuthenticationWrapper();
          },
        ),
      );

      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            EasyLoading.show(status: 'Logging out');

            await _handleLogoutUsers();
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}

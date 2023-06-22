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

  Future<void> _handleLogoutUsers(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () async {
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
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _handleLogoutUsers(context);
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}

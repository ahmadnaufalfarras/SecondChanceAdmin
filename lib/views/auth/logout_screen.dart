import 'package:flutter/material.dart';
import 'package:second_chance_admin/views/auth/login_screen.dart';

class AdminLogoutScreen extends StatefulWidget {
  const AdminLogoutScreen({super.key});

  @override
  State<AdminLogoutScreen> createState() => _AdminLogoutScreenState();
}

class _AdminLogoutScreenState extends State<AdminLogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminLoginScreen(),
              ),
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}

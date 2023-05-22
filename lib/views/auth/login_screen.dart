import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/auth_controller.dart';
import 'package:second_chance_admin/theme.dart';
import 'package:second_chance_admin/utils/button_global.dart';
import 'package:second_chance_admin/utils/show_dialog.dart';
import 'package:second_chance_admin/utils/text_form_global.dart';
import 'package:second_chance_admin/views/main_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;
  late String password;

  bool _isLoading = false;

  Future<void> _loginUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.loginUsers(email, password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return MainScreen();
        }),
      );
    } catch (error) {
      displayDialog(
        context,
        error.toString(),
        Icon(
          Icons.error,
          color: Colors.red,
          size: 60,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Text Only Without Background.png',
                    width: 125,
                    height: 125,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormGlobal(
                    text: 'Email',
                    textInputType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                      return null;
                    },
                    context: context,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormGlobal(
                    text: 'Password',
                    textInputType: TextInputType.text,
                    obsecure: true,
                    onChanged: (value) {
                      password = value;
                      return null;
                    },
                    context: context,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _loginUsers();
                    },
                    child: ButtonGlobal(isLoading: _isLoading, text: 'Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
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
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _loginUsers() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    setState(() {
      _isLoading = true;
    });
    if (username == 'admin1' && password == 'admin123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      displayDialog(
        context,
        'Username or password is wrong. Try Again.',
        Icon(
          Icons.error,
          color: primaryColor,
          size: 60,
        ),
      );
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
                    controller: _usernameController,
                    text: 'Email',
                    textInputType: TextInputType.emailAddress,
                    context: context,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormGlobal(
                    controller: _passwordController,
                    text: 'Password',
                    textInputType: TextInputType.text,
                    obsecure: true,
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

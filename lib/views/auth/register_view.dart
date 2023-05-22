import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/auth_controller.dart';
import 'package:second_chance_admin/theme.dart';
import 'package:second_chance_admin/utils/button_global.dart';
import 'package:second_chance_admin/utils/show_dialog.dart';
import 'package:second_chance_admin/utils/text_form_global.dart';
import 'package:second_chance_admin/views/auth/login_screen.dart';

class RegisterView extends StatefulWidget {
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String password;

  bool _isLoading = false;

  Future<void> _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.signUpUsers(email, password);

      setState(() {
        _formKey.currentState!.reset();
        _isLoading = false;
      });

      displayDialog(
        context,
        'Congratulations your account has been created!',
        Icon(
          Icons.check_circle_rounded,
          color: Colors.green.shade600,
          size: 60,
        ),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      displayDialog(
        context,
        error.toString(),
        Icon(
          Icons.error,
          color: Colors.red,
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
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    "Create Admin's Account",
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
                    context: context,
                    onChanged: (value) {
                      email = value;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormGlobal(
                    text: 'Password',
                    textInputType: TextInputType.text,
                    obsecure: true,
                    context: context,
                    onChanged: (value) {
                      password = value;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => _signUpUser(),
                    child:
                        ButtonGlobal(isLoading: _isLoading, text: 'Register'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already Have An Account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AdminLoginScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

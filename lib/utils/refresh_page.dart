import 'package:flutter/material.dart';
import 'package:second_chance_admin/views/main_screen.dart';

void refreshPage(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
    (Route<dynamic> route) => false,
  );
}

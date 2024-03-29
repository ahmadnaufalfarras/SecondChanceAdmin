import 'package:flutter/material.dart';
import 'package:second_chance_admin/theme.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({
    super.key,
    required this.isLoading,
    required this.text,
    this.color = blackColor,
  });

  final String text;
  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 55,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              '${text}',
              style: textButton,
            ),
    );
  }
}

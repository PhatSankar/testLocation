

import 'package:flutter/material.dart';

class PickButton extends StatelessWidget {
  String buttonTitle;
  IconData buttonIcon;
  VoidCallback onPressedButton;
  PickButton({Key? key, required this.buttonTitle, required this.buttonIcon, required this.onPressedButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressedButton,
        icon: Icon(buttonIcon),
        label: Text(buttonTitle)
    );
  }
}
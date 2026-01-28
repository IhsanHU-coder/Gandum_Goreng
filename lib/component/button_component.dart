import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String text;

  const ButtonComponent({
    super.key,
    required this.text
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
    );
  }
}
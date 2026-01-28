import 'package:flutter/material.dart';
import 'package:gandum_goreng/component/button_component.dart';

class ProductCardComponent extends StatelessWidget {
  final String text;

  const ProductCardComponent({
    super.key,
    required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue
        ),
        child: Column(
          
          children: [
            Container(
              height: 75,
              width: 75,
              color:  Colors.red,
            ),
            SizedBox(height: 8),
            Text(text),
            SizedBox(height: 10),
            ButtonComponent(text: 'Beli')
          ],
        )
      ),
    );
  }
}
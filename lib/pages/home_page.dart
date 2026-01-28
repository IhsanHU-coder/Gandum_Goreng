import 'package:flutter/material.dart';
import 'package:gandum_goreng/component/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Home Page'),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: ProductCardComponent(text: 'Text 1'),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: ProductCardComponent(text: 'Text 2'),
                ),
              ],
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
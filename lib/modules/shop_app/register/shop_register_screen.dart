import 'package:flutter/material.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          'REGISTER SCREEN',
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/home/product_list.dart';
import 'package:superexpress_tcc/util/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Super Express',
            style: TextStyle(
              color: Color(0xFFEE3F3E),
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(2, 2),
                  blurRadius: 3,
                ),
              ],
            )),
      ),
      body: const ProductList(),
      bottomNavigationBar: const Navbar(),
    );
  }
}

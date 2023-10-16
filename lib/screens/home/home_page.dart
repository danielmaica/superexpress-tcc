import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/home/product_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body:
          const ProductList(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFFEE3F3E)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Color(0xFFEE3F3E)),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFFEE3F3E)),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

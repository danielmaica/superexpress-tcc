import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/cart/cart_page.dart';
import 'package:superexpress_tcc/screens/home/home_page.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
            break;
          case 1:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const CartPage()));
            break;
          case 2:
            // Navigator.pushNamed(context, '/perfil');
            break;
        }
      },
    );
  }
}

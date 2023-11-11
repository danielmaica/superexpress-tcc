import 'package:flutter/material.dart';
import 'package:superexpress_tcc/util/navbar.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Perfil',
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
      body: const Text(
        "Em desenvolvimento...",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}

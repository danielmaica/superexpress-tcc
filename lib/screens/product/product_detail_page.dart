import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  void AddToCart() async {
    await FirebaseFirestore.instance.collection('carrinho').add({
      'id': id,
      'nome': name,
      'preco': price,
      'descricao': description,
      'imageUrl': imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        child: ListView(children: <Widget>[
          Image.network(imageUrl),

          // Espaçamento
          const SizedBox(
            height: 30,
          ),

          Text(name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20)),
          Text('Preço: $price',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          Text(
            description,
            textAlign: TextAlign.center,
          ),

          // Espaçamento
          const SizedBox(
            height: 30,
          ),

          // Botão de adicionar ao carrinho
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  stops: [
                    0.3,
                    1
                  ],
                  colors: [
                    Color(0xFFEE3F3E),
                    Color(0xFFF5DE34),
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SizedBox.expand(
              child: TextButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Adicionar ao carrinho",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 28,
                        width: 28,
                        child: Image.asset("assets/shop_cart.png"),
                      )
                    ]),
                onPressed: () {
                  AddToCart();
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

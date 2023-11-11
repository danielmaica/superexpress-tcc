import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/product/product_detail_page.dart';

class Product extends StatelessWidget {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  const Product({
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
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                id: id,
                name: name,
                price: price,
                description: description,
                imageUrl: imageUrl,
              ),
            ),
          );
        },
        child: Card(
          child: ListTile(
              title: Text(name),
              leading: Image.network(imageUrl),
              subtitle: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        '$price\n${description.length > 30 ? "${description.substring(0, 30)}..." : description}'),
                  ),
                  IconButton(
                      onPressed: () {
                        AddToCart();
                      },
                      icon: Icon(Icons.shopping_cart))
                ],
              )),
        ));
  }
}

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Product').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Algo deu errado');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando");
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Product(
              id: document.id,
              name: data['nome'] ?? '',
              price: 'R\$ ${data['preco'].toString() ?? '0'}',
              description: data['descricao'] ?? '',
              imageUrl: data['imageUrl'] ?? '',
            );
          }).toList(),
        );
      },
    );
  }
}

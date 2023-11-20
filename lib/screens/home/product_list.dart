import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/product/product_detail_page.dart';

class Product extends StatelessWidget {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;
  final int stock;

  const Product({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.stock,
  });

  void AddToCart(BuildContext context) async {
    // Referência para a coleção "carrinho"
    CollectionReference carrinho =
        FirebaseFirestore.instance.collection('carrinho');

    // Consulta para verificar a existência do produto pelo ID
    QuerySnapshot querySnapshot =
        await carrinho.where('id', isEqualTo: id).get();

    if (querySnapshot.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('carrinho').add({
        'id': id,
        'nome': name,
        'preco': price,
        'descricao': description,
        'imageUrl': imageUrl,
        'estoque': stock,
        'quantidade': 1
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto adicionado ao carrinho!'),
          backgroundColor: Colors.greenAccent,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Este produto já está no carrinho, escolha outro!'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                stock: stock,
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
                        AddToCart(context);
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
                stock: data['estoque']);
          }).toList(),
        );
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
      child: ListTile(
        title: Text(name),
        subtitle: Text(price),
        leading: Image.network(imageUrl),
      ),
    );
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
          return Text('Algo deu errado');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Carregando");
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

class ProductDetailPage extends StatelessWidget {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  ProductDetailPage({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: <Widget>[
          Image.network(imageUrl),
          Text(name),
          Text(price),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/product/product_detail_page.dart';

class Product extends StatelessWidget {
  final String id;
  final String name;
  final String price;
  final String imageUrl;

  const Product({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProductDetailPage()));
        },
        child: Card(
          shadowColor: Colors.black54,
          child: Column(
            children: [
              Image.network(imageUrl),
              ListTile(
                title: Text(name),
                subtitle: Text(price),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    // Adicionar ao carrinho
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Product(
            id: '1',
            name: 'Maçã',
            price: 'R\$ 2.50',
            imageUrl:
                'https://mambodelivery.vtexassets.com/arquivos/ids/173278-150-auto?v=637883315164100000&width=150&height=auto&aspect=true'),
      ],
    );
  }
}

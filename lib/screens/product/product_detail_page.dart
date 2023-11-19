import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;
  final int stock;

  ProductDetailPage({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.stock,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  void AddToCart(BuildContext context) async {
    // Referência para a coleção "carrinho"
    CollectionReference carrinho =
        FirebaseFirestore.instance.collection('carrinho');

    // Consulta para verificar a existência do produto pelo ID
    QuerySnapshot querySnapshot =
        await carrinho.where('id', isEqualTo: widget.id).get();

    if (querySnapshot.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('carrinho').add({
        'id': widget.id,
        'nome': widget.name,
        'preco': widget.price,
        'descricao': widget.description,
        'imageUrl': widget.imageUrl,
        'estoque': widget.stock,
        'quantidade': quantity
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto adicionado ao carrinho!'),
          backgroundColor: Colors.greenAccent,
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Este produto já está no carrinho, escolha outro!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        child: ListView(children: <Widget>[
          Image.network(widget.imageUrl),

          // Espaçamento
          const SizedBox(
            height: 30,
          ),

          Text(widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20)),
          Text('Preço: ${widget.price}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green)),
          Text(
            widget.description,
            textAlign: TextAlign.center,
          ),
          // Text(
          //   'Em estoque: ${widget.stock}',
          //   textAlign: TextAlign.center,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quantidade: $quantity',
                textAlign: TextAlign.center,
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Quantidade mínima atingida.'),
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (quantity < widget.stock) {
                    setState(() {
                      quantity++;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Máximo de produtos em estoque atingido.'),
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                    );
                  }
                },
              ),
            ],
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
                  AddToCart(context);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

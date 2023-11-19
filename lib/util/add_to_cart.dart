import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void AddToCart(BuildContext context, String id, String name, int price,
    String description, String imageUrl, int stock, int quantity) async {
  // Referência para a coleção "carrinho"
  CollectionReference carrinho =
      FirebaseFirestore.instance.collection('carrinho');

  // Consulta para verificar a existência do produto pelo ID
  QuerySnapshot querySnapshot = await carrinho.where('id', isEqualTo: id).get();

  if (querySnapshot.docs.isEmpty) {
    await FirebaseFirestore.instance.collection('carrinho').add({
      'id': id,
      'nome': name,
      'preco': price,
      'descricao': description,
      'imageUrl': imageUrl,
      'estoque': stock,
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

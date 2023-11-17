import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superexpress_tcc/util/navbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  void removeProduct(BuildContext context, String id) async {
    // Remove o item do carrinho
    await FirebaseFirestore.instance.collection('carrinho').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produto removido do carrinho!'),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Carrinho',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('carrinho').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Algo deu errado');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Carregando");
          }

          // Calcula o valor total
          double total = snapshot.data!.docs.fold(0, (tot, doc) {
            String precoStr = (doc.data() as Map<String, dynamic>)['preco'];
            precoStr = precoStr.replaceAll('R\$', '').replaceAll(',', '.');
            int quantity =
                (doc.data() as Map<String, dynamic>)['quantidade'] ?? 1;
            return tot + double.parse(precoStr) * quantity;
          });

          // Formata o valor total para ter duas casas decimais
          String totalStr = total.toStringAsFixed(2);

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    int quantity = (document.data()
                            as Map<String, dynamic>)['quantidade'] ??
                        1;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.network(data['imageUrl']),
                        title: Text(data['nome']),
                        subtitle: Text('Quantidade: $quantity'),
                        trailing: Text(data['preco']),
                        onTap: () => removeProduct(context, document.id),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Text(
                      'R\$ $totalStr',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Adicione aqui a lógica para finalizar a compra
                },
                child: const Text('Finalizar Compra'),
              ),
            ],
          );
        },
      ),
    );
  }
}

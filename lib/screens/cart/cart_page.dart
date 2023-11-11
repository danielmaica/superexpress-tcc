import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/home/product_list.dart';
import 'package:superexpress_tcc/util/navbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

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
            return tot + double.parse(precoStr);
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
                    return ListTile(
                      title: Text(data['nome']),
                      subtitle: Text(data['preco']),
                      leading: Image.network(data['imageUrl']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Remove o item do carrinho
                          FirebaseFirestore.instance
                              .collection('carrinho')
                              .doc(document.id)
                              .delete();
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Total: R\$ $totalStr'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Compra Concluída'),
                        content:
                            const Text('Sua compra foi concluída com sucesso!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Finalizar Compra'),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}

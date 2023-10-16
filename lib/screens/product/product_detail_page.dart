import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Produto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/maca.png"),
              ),
              const Text(
                "Maçã",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Sabor suculento e naturalmente doce, esta maçã fresca é a escolha perfeita para uma mordida revigorante e saudável. Uma explosão de frescor em cada pedaço!",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              const Text(
                "Peso: 130g",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Valor: R\$10,50/kg",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Promoção: R\$9,90/kg \n"
                "comprando 5 unidades",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              const OutlinedButton(
                onPressed: null,
                style: ButtonStyle(
                    side: MaterialStatePropertyAll(BorderSide(
                  color: Colors.black,
                  width: 2,
                ))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Adicionar ao carrinho",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

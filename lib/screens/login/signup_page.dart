import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(
            top: 100,
            left: 40,
            right: 40,
          ),
          color: const Color(0xFFFFFFFF),
          child: Form(
            child: ListView(
              children: <Widget>[
                // Título
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text("Crie sua conta",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEE3F3E),
                        fontSize: 25,
                      )),
                ),

                const SizedBox(
                  height: 20,
                ),

                // E-mail
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    focusColor: Color(0xFFEE3F3E),
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite seu e-mail.';
                    } else if (!email.contains('@')) {
                      return 'Digite um e-mail válido.';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),

                // Senha
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    focusColor: Color(0xFFEE3F3E),
                  ),
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Digite sua senha.';
                    } else if (password.length <= 6) {
                      return 'Digite uma senha mais forte.';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),

                // Telefone
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Telefone",
                    hintText: '(51) 99584-6522',
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    focusColor: Color(0xFFEE3F3E),
                  ),
                  validator: (phone) {
                    if (phone == null || phone.isEmpty) {
                      return 'Digite seu telefone.';
                    } else if (phone.length < 10 || phone.length > 15) {
                      return 'Digite um número de telefone válido.';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                // Botão Finalizar Cadastro
                Container(
                  height: 60,
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
                      child: const Text(
                        'Finalizar cadastro',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {}
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

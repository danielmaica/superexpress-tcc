// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superexpress_tcc/screens/login/login_page.dart';

class ResetPassPage extends StatefulWidget {
  const ResetPassPage({Key? key}) : super(key: key);

  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  String get email => _emailController.text;

  Future<void> doResetPass() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Um email de redefinição de senha foi enviado.'),
          backgroundColor: Colors.greenAccent,
        ));
        // FirebaseAuthAppNavigator.goToHome(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage(
                    title: 'Login',
                  )),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Ocorreu um erro, tente novamente!'),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

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
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Logo
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("assets/logo.png"),
              ),

              // Título
              Container(
                height: 40,
                alignment: Alignment.center,
                child: const Text("Recupere sua senha",
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
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  hintText: "Digite seu e-mail",
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
                      'Enviar e-mail de Recuperação',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      doResetPass();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

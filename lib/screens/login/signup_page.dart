// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:superexpress_tcc/screens/login/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void doSignUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Usuário cadastrado.'),
          backgroundColor: Colors.greenAccent,
        ));
        if (user != null) {
          // FirebaseAuthAppNavigator.goToHome(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginPage(
                      title: 'Login',
                    )),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('A senha é muito fraca'),
            backgroundColor: Colors.redAccent,
          ));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('O e-mail já está em uso'),
            backgroundColor: Colors.redAccent,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Erro ao cadastrar o usuário.'),
            backgroundColor: Colors.redAccent,
          ));
        }
      } catch (e) {
        print('Erro ao cadastrar o usuário: $e');
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
                controller: _emailController,
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

              TextFormField(
                keyboardType: TextInputType.text,
                controller: _passwordController,
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
                      doSignUp();
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

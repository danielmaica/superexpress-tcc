// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/home/home_page.dart';
import 'package:superexpress_tcc/screens/login/reset_pass_page.dart';
import 'package:superexpress_tcc/screens/login/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required String title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  void doLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (user != null) {
          // FirebaseAuthAppNavigator.goToHome(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Inválido"),
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
            top: 60,
            left: 40,
            right: 40,
          ),
          color: const Color(0xFFFFFFFF),
          child: Form(
            key: _formKey,
            child: ListView(
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
                  child: const Text("Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEE3F3E),
                        fontSize: 25,
                      )),
                ),

                // Espaçamento
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
                      fontSize: 20,
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
                  controller: _passwordController,
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

                // Recuperar Senha
                Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text("Recuperar Senha",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEE3F3E),
                          fontSize: 15,
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPassPage(),
                        ),
                      );
                    },
                  ),
                ),

                // Espaçamento
                const SizedBox(
                  height: 40,
                ),

                // Botão de Login
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
                              "Login",
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
                        doLogin();
                      },
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // Botão de Login com Facebook
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      color: Color(0xFF3C5A99),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: SizedBox.expand(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  "Login com Facebook",
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
                                  child: Image.asset("assets/fb-icon.png"),
                                )
                              ]))),
                ),

                // Espaçamento
                const SizedBox(
                  height: 10,
                ),

                // Cadastre-se
                SizedBox(
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    },
                    child: const Text(
                      "Cadastre-se",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEE3F3E),
                          fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

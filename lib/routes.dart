import 'package:flutter/material.dart';
import 'package:superexpress_tcc/screens/home/home_page.dart';
import 'package:superexpress_tcc/screens/login/login_page.dart';

class FirebaseAuthAppRoutes {
  var routes = <String, WidgetBuilder>{
    "/home": (BuildContext context) => HomePage(),
    "/login": (BuildContext context) => LoginPage(
          title: 'login',
        ),
  };
}

//Importaciones de librerias y pantallas
import 'package:final_project/screens/login_page.dart';
import 'package:final_project/screens/signup_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //Mostrar página de Login al iniciar
  bool showLoginPage = true;

  //Intercambiar entre página de Login y Register
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  //Cambiará de acuedo al evento onTap colocado en una frase dentro de las pantallas
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return SignUpPage(
        onTap: togglePages,
      );
    }
  }
}

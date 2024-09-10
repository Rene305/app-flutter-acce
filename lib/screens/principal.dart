//PANTALLA DE INICIO
//Importaciones de librerias y pantallas necesarias
import 'package:final_project/screens/login_or_register_page.dart';
import 'package:final_project/screens/menu_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  //Ver el estado del usuario
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //Widget que cambiará la pantalla entre el Login - SignUp - HomePage
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //En caso de estar logueado el usuario pasará a la Pantalla de denuncias.
          if (snapshot.hasData) {
            return const MenuScreen();
            //En caso de no estar logueado mostrará el Login o SignUp
          } else {
            return const LoginOrRegisterPage();
          }
        });
  }
}

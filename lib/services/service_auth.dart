//PAGINA NECESARIA PARA LA AUTENTICACION DE USUARIOS

/*import 'package:demo_wissen/main.dart';
import 'package:flutter/material.dart';*/

//Importaciones de librerias necesarias

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/model_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceAuth {
  ServiceAuth();
  //Se llama a la instancia para la autenticación desde la librería de Firebase
  final authentication = FirebaseAuth.instance;

  //Función para el Ingreso de usuarios registrados
  Future<bool> signIn(String email, String password) async {
    try {
      final userCredentials = await authentication.signInWithEmailAndPassword(
          email: email, password: password);
      //Se procede a guardar en las SharedPreferences el id del usuario logueado.
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString("user_uid", userCredentials.user!.uid);
    } catch (e) {
      developer.log(e.toString());
      return false;
    }
  }

  //Función para el Ingreso de usuarios anonimos
  Future<bool> signInAnonymous() async {
    try {
      final userCredentials = await authentication.signInAnonymously();
      //Se procede a guardar en las SharedPreferences el id del usuario logueado.
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(
          "user_uid", userCredentials.user!.isAnonymous ? "anonimo" : "");
    } catch (e) {
      developer.log(e.toString());
      return false;
    }
  }

  //Función para el Registro de usuarios en la app
  Future<bool> signUp(String email, String password) async {
    try {
      final userCredentials = await authentication
          .createUserWithEmailAndPassword(email: email, password: password);
      //developer.log(userCredentials.user!.uid);

      /*CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(userCredentials.user!.uid).set({
        'email': email,
        'password': password,
        'role': 'user',
      });*/
      //Despues de crear el usuario se procede a guardar el uid del usuario creado.
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString("user_uid", userCredentials.user!.uid);
    } catch (e) {
      developer.log(e.toString());
      return false;
    }
  }

  //Función que permite el logout del usuario.
  void signUserOut(bool isAnonymous) async {
    if (isAnonymous) {
      authentication.currentUser!.delete();
    }
    authentication.signOut();

    final prefs = await SharedPreferences.getInstance();
    //Se vacía la información de las SharedPreferences
    await prefs.clear();
  }

  Future<bool> dataCheck(String uid) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final querySnapshot = await usersCollection.doc(uid).get();
    if (querySnapshot.exists) {
      developer.log("existen datos");
      return true;
    } else {
      developer.log("no existen datos");
      return false;
    }
  }

  Future<bool> dataRegister(String uid, UserApp user) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    try {
      Map<String, dynamic> userData = user.toJson();
      await usersCollection.doc(uid).set(userData);
      return true;
    } catch (e) {
      developer.log(e.toString());
      return false;
    }
  }
}

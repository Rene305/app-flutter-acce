import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import 'package:final_project/models/model_denuncia.dart';
//Importación del modelo Foundation

//Función que llamará al Servicio ServiceFoundations
class ServiceDenuncias {
  ServiceDenuncias();
  final String nameRef = "denuncias";
  //Llama la instancia de la Base de Datos de Firebase_Firestore
  FirebaseFirestore db = FirebaseFirestore.instance;

  //Función que recuperará toda la colección de fundaciones para poder visualizarlas
  Future<List> getDenuncias(String uid) async {
    try {
      final querySnapshot =
          await db.collection(nameRef).where("userID", isEqualTo: uid).get();
      List result = [];
      for (var element in querySnapshot.docs) {
        final data = Map<String, dynamic>.from(element.data());
        final newDenuncia = Denuncia.fromJson(data);
        result.add(newDenuncia);
      }
      return result;
    } catch (e) {
      developer.log(e.toString());
      return [];
    }
  }

  //FUNCIONES UTILES SOLO PARA EL ADMIN (SE PROCEDE EN LA PARTE WEB)

  //Llama a los servicios que se necesitarán para realizar el CRUD en la BD.
  Future<String> createDenuncia(Denuncia denuncia) async {
    try {
      DocumentReference reference =
          await db.collection(nameRef).add(denuncia.toJson());
      return reference.id;
    } catch (e) {
      developer.log(e.toString());
      return "";
    }
  }
/*
  Future<void> editFoundation(String uid, Foundation editFoundation) async {
    try {
      await db.collection(nameRef).doc(uid).update(editFoundation.toJson());
    } catch (e) {
      developer.log(e.toString());
    }
  }

  Future<void> deleteFoundation(String uid) async {
    try {
      await db.collection(nameRef).doc(uid).delete();
    } catch (e) {
      developer.log(e.toString());
    }
  }*/
}

//PAGINA QUE TENDRA LOS METODOS NECESARIO PARA LAS FUNDACIONES
//Importacioes de librerías
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import 'package:final_project/models/model_foundation.dart';
//Importación del modelo Foundation

//Función que llamará al Servicio ServiceFoundations
class ServiceFoundations {
  ServiceFoundations();
  final String nameRef = "foundation";
  //Llama la instancia de la Base de Datos de Firebase_Firestore
  FirebaseFirestore db = FirebaseFirestore.instance;

  /*Stream<List>? getFoundations() {
    try {
      return db.collection(nameRef).snapshots().map((QuerySnapshot query) {
        List result = [];
        for (var element in query.docs) {
          final data = Map<String, dynamic>.from(element.data() as Map);
          final newFoundation = {
            "foundation": Foundation.fromJson(data),
            "uid": element.id
          };
          result.add(newFoundation);
        }
        return result;
      });
    } catch (e) {
      developer.log(e.toString());
      return null;
    }
  }*/
  //Función que recuperará toda la colección de fundaciones para poder visualizarlas
  Future<List<Foundation>> getFoundations() async {
    try {
      final querySnapshot = await db.collection(nameRef).get();
      List<Foundation> result = [];

      for (var element in querySnapshot.docs) {
        final data = Map<String, dynamic>.from(element.data());
        final newFoundation = Foundation.fromJson(data);
        result.add(newFoundation);
      }

      return result;
    } catch (e) {
      developer.log(e.toString());
      return [];
    }
  }

  //FUNCIONES UTILES SOLO PARA EL ADMIN (SE PROCEDE EN LA PARTE WEB)
  /*
  //Llama a los servicios que se necesitarán para realizar el CRUD en la BD.
  Future<String> createFoundation(Foundation foundation) async {
    try {
      DocumentReference reference =
          await db.collection(nameRef).add(foundation.toJson());
      return reference.id;
    } catch (e) {
      developer.log(e.toString());
      return "";
    }
  }

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

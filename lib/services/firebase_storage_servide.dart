//PANTALLA PARA EL USO DE FIREBASE_STORAGE

//Importación de librerías
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer' as developer;
import 'dart:io';

//Función para inicializar el servicio de Storage
class FirebaseStorageService {
  FirebaseStorageService(String nameRef) {
    _nameRef = nameRef;
  }

  final _storage =
      FirebaseStorage.instance; //El nombre de la Instancia del Storage
  late String _nameRef; //El nombre del archivo de la imagen

  //Función para subir la foto al Storage
  Future<void> uploadFile(File file) async {
    try {
      Reference ref = _storage.ref().child(
          "assets/logosFoundations/$_nameRef"); //Ruta del lugar en donde guardar.
      await ref.putFile(file); //Añadir el objeto al Storage
    } catch (ex) {
      developer.log("El error al subir la foto: $ex");
    }
  }

  //Función para descargar la URL de la foto subida
  Future<String?> downloadURL() async {
    try {
      Reference ref = _storage.ref().child(
          "assets/logosFoundations/$_nameRef"); //Obtener la referencia de la imagen subida.
      return await ref.getDownloadURL(); //Devolver la url de la imagen.
    } catch (ex) {
      developer.log(ex.toString());
      return null;
    }
  }
}

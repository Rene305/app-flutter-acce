import 'package:final_project/models/model_denuncia.dart';
import 'package:final_project/services/denuncia_service%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:intl/intl.dart';

class CreateDenunciaPage extends StatefulWidget {
  //Función en la que se trabajará el cambio de pantallas
  const CreateDenunciaPage({super.key});

  @override
  State<CreateDenunciaPage> createState() => _CreateDenunciaPageState();
}

class _CreateDenunciaPageState extends State<CreateDenunciaPage> {
  final user = FirebaseAuth.instance.currentUser;
  final String _currentDate =
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  bool _isSaving = false;
  final _formKey = GlobalKey<FormState>();
  final Denuncia _model = Denuncia(
      denunciante: "",
      denuncia: "",
      fecha: "",
      estado: "En Proceso",
      userID: "");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).cardColor,
                                        spreadRadius: 3)
                                  ]),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      "Crear Denuncia",
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
                                    ),
                                  ),
                                  TextFormField(
                                    onSaved: (value) =>
                                        _model.denunciante = value!,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.title),
                                        hintText: "Ingrese Nombre",
                                        label: Text("Nombre Denunciante")),
                                  ),
                                  TextFormField(
                                    maxLines: 5,
                                    onSaved: (value) =>
                                        _model.denuncia = value!,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.title),
                                        hintText: "Ingrese Denuncia",
                                        label: Text("Denuncia")),
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue: _currentDate,
                                    onSaved: (value) => _model.fecha = value!,
                                    decoration: const InputDecoration(
                                        icon: Icon(Icons.title),
                                        label: Text("Fecha de la Denuncia")),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: _isSaving
                                  ? const Center(
                                      child: SizedBox.square(
                                          dimension: 40.0,
                                          child: CircularProgressIndicator()))
                                  : ElevatedButton.icon(
                                      onPressed: () async {
                                        _saveForm().then((value) {
                                          if (value.isNotEmpty) {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Ingreso realizado!"),
                                                    icon:
                                                        const Icon(Icons.check),
                                                    content: Text(
                                                        "La denuncia fue registrada con el ID: $value"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                            "Aceptar"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                            setState(() {});
                                          } else {
                                            const snackBar = SnackBar(
                                                content: Text(
                                                    "Por favor, rellene todo el formulario"));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                          setState(() {});
                                        });
                                      },
                                      icon: const Icon(Icons.save),
                                      label: const Text("Guardar")),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _saveForm() async {
    bool isValidate = _formKey.currentState!.validate();
    if (!isValidate) {
      return "";
    }
    _isSaving = true;
    setState(() {});
    _formKey.currentState!.save();
    _model.userID = user!.uid;
    final service = ServiceDenuncias();
    String result = await service.createDenuncia(_model);
    developer.log("El resultado de la creacion es: $result");

    _formKey.currentState!.reset();
    return result;
  }
}
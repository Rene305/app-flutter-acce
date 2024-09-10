import 'package:final_project/models/model_user.dart';
import 'package:final_project/services/service_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

//Lista de tipos de mantenimiento
const List<String> generoForm = ['Masculino', 'Femenino'];
//Lista de tipos prioridades
const List<String> tipoPaciente = [
  "Paciente con cáncer",
  "Conozco a una persona con cáncer"
];

class DataRegisterForm extends StatefulWidget {
  const DataRegisterForm({super.key});

  @override
  State<DataRegisterForm> createState() => _DataRegisterFormState();
}

class _DataRegisterFormState extends State<DataRegisterForm> {
  final userActive = FirebaseAuth.instance.currentUser;
  bool _isSaving = false;
  final _formKey = GlobalKey<FormState>();
  String _generoGroupValue = generoForm.first;
  String _tipoPacienteGroupValue = tipoPaciente.first;
  final UserApp _user = UserApp(
      nombre: "",
      cedula: "",
      celular: "",
      ciudad: "",
      provincia: "",
      edad: 0,
      correo: "",
      sexo: generoForm[0],
      tipoPaciente: tipoPaciente[0]);

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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
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
                                      "Datos Personales",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RadioGroup<String>.builder(
                                          direction: Axis.vertical,
                                          groupValue: _tipoPacienteGroupValue,
                                          onChanged: (value) {
                                            setState(() {
                                              _tipoPacienteGroupValue =
                                                  value ?? tipoPaciente[0];
                                              _user.tipoPaciente =
                                                  _tipoPacienteGroupValue;
                                            });
                                          },
                                          items: tipoPaciente,
                                          itemBuilder: (item) =>
                                              RadioButtonBuilder(item)),
                                    ],
                                  ),
                                  TextFormField(
                                    onSaved: (value) => _user.nombre = value!,
                                    validator: (value) =>
                                        _validateField(value!),
                                    decoration: const InputDecoration(
                                      hintText: "Nombre",
                                    ),
                                  ),
                                  TextFormField(
                                    onSaved: (value) => _user.cedula = value!,
                                    validator: (value) =>
                                        _validateField(value!),
                                    decoration: const InputDecoration(
                                      hintText: "Cédula",
                                    ),
                                  ),
                                  TextFormField(
                                    onSaved: (value) =>
                                        _user.edad = int.parse(value!),
                                    validator: (value) =>
                                        _validateField(value!),
                                    decoration: const InputDecoration(
                                      hintText: "Edad",
                                    ),
                                  ),
                                  TextFormField(
                                    onSaved: (value) => _user.ciudad = value!,
                                    validator: (value) =>
                                        _validateField(value!),
                                    decoration: const InputDecoration(
                                      hintText: "Ciudad",
                                    ),
                                  ),
                                  TextFormField(
                                    onSaved: (value) =>
                                        _user.provincia = value!,
                                    validator: (value) =>
                                        _validateField(value!),
                                    decoration: const InputDecoration(
                                      hintText: "Provincia",
                                    ),
                                  ),
                                  TextFormField(
                                    onSaved: (value) => _user.celular = value!,
                                    validator: (value) =>
                                        _validateField(value!),
                                    decoration: const InputDecoration(
                                      hintText: "Celular",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Género:"),
                                        RadioGroup<String>.builder(
                                            direction: Axis.horizontal,
                                            groupValue: _generoGroupValue,
                                            onChanged: (value) {
                                              _generoGroupValue =
                                                  value ?? generoForm[0];
                                              _user.sexo = _generoGroupValue;
                                              setState(() {});
                                            },
                                            items: generoForm,
                                            itemBuilder: (item) =>
                                                RadioButtonBuilder(item)),
                                      ],
                                    ),
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
                                                    content: const Text(
                                                        "Sus datos han sido registrados correctamente"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                            "Aceptar"),
                                                        onPressed: () {
                                                          Navigator
                                                              .pushReplacementNamed(
                                                                  context,
                                                                  '/menu');
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

  String? _validateField(value) {
    if (value!.isEmpty) {
      return "El campo no puede estar vacío";
    }
    return null;
  }

  Future<String> _saveForm() async {
    bool isValidate = _formKey.currentState!.validate();
    if (!isValidate) {
      return "";
    }
    _isSaving = true;
    setState(() {});
    _formKey.currentState!.save();
    _user.correo = userActive!.email!;
    final service = ServiceAuth();
    bool result = await service.dataRegister(userActive!.uid, _user);
    _formKey.currentState!.reset();
    return result.toString();
  }
}

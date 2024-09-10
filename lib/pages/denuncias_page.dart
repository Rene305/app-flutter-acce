import 'package:final_project/services/service_auth.dart';
import 'package:final_project/widget/forms/form_denuncia.dart';
import 'package:final_project/widget/list_denuncia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> contentTitle = ["Listado de Denuncias", "Crear Denuncia"];

class DenunciaPage extends StatefulWidget {
  const DenunciaPage({super.key});

  @override
  State<DenunciaPage> createState() => _DenunciaPageState();
}

class _DenunciaPageState extends State<DenunciaPage> {
  var _index = 0;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Image.asset('assets/images/icons_ACCE/icono.png'),
        title: Text(contentTitle[_index],
            style: Theme.of(context).textTheme.displayLarge),
        actions: [
          IconButton(
            onPressed: () async {
              ServiceAuth().signUserOut(user!.isAnonymous);

              await Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: !user!.isAnonymous
          ? Center(
              //Imagen de Fondo
              child: Stack(fit: StackFit.expand, children: [
                Image.asset(
                  "assets/images/backgrounds/bgd.png",
                  fit: BoxFit.cover,
                ),
                //Contenido de las pantallas
                SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: _index == 0
                          ? const ShowDenunciaPage()
                          : const CreateDenunciaPage()),
                )
              ]),
            )
          : const Center(
              child: Text("Para usar esta opción debe tener una cuenta")),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: ((value) {
            _index = value; //Cambia el valor del atributo
            setState(() {});
          }),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/icons_buttons/ic_lista.png",
                  width: 50,
                  height: 50,
                ),
                label: "Listado de Denuncias"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/icons_buttons/ic_listado.png",
                  width: 50,
                  height: 50,
                ),
                label: "Crear Denuncia"),
          ]),
    );
  }
}

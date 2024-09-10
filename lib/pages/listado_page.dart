import 'package:final_project/models/model_foundation.dart';
import 'package:final_project/pages/foundations_map_page.dart';
import 'package:final_project/services/foundation_service.dart';
import 'package:final_project/services/service_auth.dart';
import 'package:final_project/widget/forms/list_fb_fundacion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> contentTitle = [
  "Listado de Fundaciones",
  "Mapa de las Fundaciones"
];

class ListadoPage extends StatefulWidget {
  const ListadoPage({super.key});

  @override
  State<ListadoPage> createState() => _ListadoPageState();
}

class _ListadoPageState extends State<ListadoPage> {
  final user = FirebaseAuth.instance.currentUser;
  List<Foundation> _foundationList = []; // Mantén aquí la lista de fundaciones
  var _index = 0;

  @override
  void initState() {
    _loadFoundationList(); // Carga la lista de fundaciones al inicio
    super.initState();
  }

  Future<void> _loadFoundationList() async {
    final service = ServiceFoundations();
    List<Foundation> list = await service.getFoundations();
    setState(() {
      _foundationList = list;
    });
  }

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
      body: Center(
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
                    ? ListFB(foundationList: _foundationList)
                    : MapScreen(foundationList: _foundationList)),
          )
        ]),
      ),
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
                label: "Listado de Fundaciones"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/icons_buttons/ic_listado.png",
                  width: 50,
                  height: 50,
                ),
                label: "Mapa de Fundaciones"),
          ]),
    );
  }
}

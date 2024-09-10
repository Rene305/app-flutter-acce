//import 'package:demo_wissen/screens/home_page.dart';

//PANTALLA PARA EL SIGNUP
import 'package:final_project/models/model_denuncia.dart';
import 'package:final_project/services/denuncia_service%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowDenunciaPage extends StatefulWidget {
  const ShowDenunciaPage({super.key});

  @override
  State<ShowDenunciaPage> createState() => _ShowDenunciaPageState();
}

class _ShowDenunciaPageState extends State<ShowDenunciaPage> {
  Future<List>? _listFuture;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _listFuture =
        _loadData(); //Carga de información y almacenamiento en su variable
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Construcción del Widget que contendrá las fundaciones.
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
            future: _listFuture,
            builder: (context, snapshot) {
              //Opción que mostrará mientras carga la información
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Text("Leyendo datos...."),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox.square(
                              dimension: 50.0,
                              child: CircularProgressIndicator()),
                        )
                      ],
                    ),
                  ),
                );

                //En caso de contener errores al momento de la carga, mostrará un mensaje de error.
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching data'));
                //En caso de estar todo correcto, procederá a mostrar la información
              } else {
                //La variable data almacenará la información recuperada o en su caso por defecto será una lista vacía
                final data = snapshot.data ?? [];
                if (data.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("No existen datos"),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        //Generación de la lista con la informacion recuperada y/o filtrada.
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            Denuncia? denuncia = data[index];
                            //String uid = filteredData[index]["uid"];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                onTap: () {
                                  setState(() {});
                                },
                                title: Text(denuncia!.denunciante),
                                subtitle: Text(denuncia.fecha),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Estado"),
                                    Text(denuncia.estado)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  //Función que permite la carga de información desde Firebase, llamando al servicio ServiceFoundations()
  Future<List> _loadData() async {
    final service = ServiceDenuncias();
    return service.getDenuncias(user!.uid);
  }
}

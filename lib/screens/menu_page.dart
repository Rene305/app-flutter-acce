import 'package:final_project/models/category.dart';
import 'package:final_project/services/service_auth.dart';
import 'package:final_project/widget/forms/register_data_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<bool> _datosRegistradosFuture;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _datosRegistradosFuture =
        _valorData(); // Carga la lista de fundaciones al inicio
    super.initState();
  }

  Future<bool> _valorData() async {
    return await ServiceAuth().dataCheck(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/icons_ACCE/icono.png'),
          title: Text(
            "Menú",
            style: Theme.of(context).textTheme.displayLarge,
          ),
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
        body: FutureBuilder<bool>(
          future: _datosRegistradosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child:
                    CircularProgressIndicator(), // Muestra CircularProgressIndicator mientras espera
              );
            } else if (snapshot.hasError) {
              // Manejar error si lo hubiera
              return const Center(
                child: Text('Error al cargar los datos'),
              );
            } else {
              final bool datosRegistrados = snapshot.data ?? false;

              return (!datosRegistrados && !user!.isAnonymous)
                  ? const Center(
                      child: DataRegisterForm(),
                    )
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/backgrounds/bgd.png"),
                            fit: BoxFit.cover),
                      ),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(15),
                        shrinkWrap: true,
                        itemCount: menu.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, menu[index].route);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    menu[index].icon,
                                    width: 125,
                                  ),
                                  Text(menu[index].name)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
            }
          },
        ));
  }
}

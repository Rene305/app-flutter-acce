//Importaciones de pantallas y librerías
import 'package:final_project/pages/denuncias_page.dart';
import 'package:final_project/pages/listado_page.dart';
import 'package:final_project/pages/mantenimiento_page.dart';
import 'package:final_project/screens/animacion_inicio.dart';
import 'package:final_project/screens/encuesta_page.dart';
import 'package:final_project/screens/menu_page.dart';
import 'package:final_project/screens/principal.dart';
import 'package:final_project/themes/theme.dart';
import 'package:flutter/material.dart';
//Librerías de Firebase y SharedPreferences
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Main cambia a ser Future debido a necesitar la inicialización de Firebase y SharedPreferences
Future<void> main() async {
  initializeDateFormatting('es_ES', null);
  WidgetsFlutterBinding.ensureInitialized();
  //Inicialización de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Carga de SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  //Guardar usuario en caso de estar logueado.
  String uid = prefs.getString("user_uid") ?? "";
  runApp(MyApp(uid: uid));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      //theme: ThemeData(),
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const PrincipalPage(),
        '/menu': (context) => const MenuScreen(),
        '/listado': (context) => const ListadoPage(),
        '/denuncia': (context) => const DenunciaPage(),
        '/mantenimiento': (context) => const MantenimientoPage(),
        '/preguntas': (context) => const QuestionsScreen(),
        '/SplashScreen': (context) => const SplashScreen(),
      },
      initialRoute: '/SplashScreen',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => const MantenimientoPage());
      },
    );
  }
}

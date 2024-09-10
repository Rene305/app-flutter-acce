//PANTALLA DE LOGIN
//Importaciones de librerías
import 'package:final_project/services/service_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class LoginPage extends StatefulWidget {
  //Función en la que se trabajará el cambio de pantallas
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Permitirá mostrar u ocultar la contraseña
  bool _showPassword = false;
  //Controladores del formulario
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/backgrounds/bgd.png",
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/images/icons_ACCE/vertical.png'),
                              Text(
                                "Iniciar Sesión",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.email),
                                    labelText: "Correo Electrónico"),
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: !_showPassword,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.key),
                                    labelText: "Contraseña",
                                    suffixIcon: TextButton(
                                      onPressed: () => setState(
                                          () => _showPassword = !_showPassword),
                                      child: _showPassword
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                    )),
                              ),
                              const SizedBox(
                                height: 25.0,
                              ),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await _login();
                                },
                                icon: const Icon(Icons.login),
                                label: const Text(
                                  "Ingresar",
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text("0"),
                              ),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await _loginAnonimo();
                                },
                                icon: const Icon(Icons.accessibility),
                                label: const Text("Ingresar como Invitado"),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("No eres miembro"),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: widget.onTap,
                                    child: Text(
                                      "Regístrate Ahora",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Función que permitira llamar al servicio y lograr el login
  Future<bool> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    developer.log("Email:  $email");
    developer.log("Password:  $password");
    if (email == "" && password == "") {
      return false;
    }
    ServiceAuth serviceAuth = ServiceAuth();
    return await serviceAuth.signIn(email, password);
  }

  Future<bool> _loginAnonimo() async {
    ServiceAuth serviceAuth = ServiceAuth();
    return await serviceAuth.signInAnonymous();
  }
}

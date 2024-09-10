//PANTALLA PARA EL SIGNUP
import 'package:final_project/services/service_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class SignUpPage extends StatefulWidget {
  //Función en la que se trabajará el cambio de pantallas
  final Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Permitirá mostrar u ocultar las contraseñas
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  //Controladores del formulario
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(
            "assets/images/backgrounds/bgd.png",
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 25, 25, 0),
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
                              "Crear Usuario",
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
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: !_showConfirmPassword,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.key),
                                  labelText: "Confirmar Contraseña",
                                  suffixIcon: TextButton(
                                    onPressed: () => setState(() =>
                                        _showConfirmPassword =
                                            !_showConfirmPassword),
                                    child: _showConfirmPassword
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  )),
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  _signUp().then(
                                    (value) {
                                      if (!value) {
                                        const snackBar = SnackBar(
                                            content: Text(
                                                "Rellene correctamente los datos"));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                  );
                                },
                                icon: const Icon(Icons.login),
                                label: const Text("Registrarse")),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Ya está registrado?"),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text(
                                    "Ingresar",
                                    style: TextStyle(color: Colors.blue),
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
        ]),
      ),
    );
  }

//Función que permitira llamar al servicio y lograr el signup
  Future<bool> _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    developer.log("Email:  $email");
    developer.log("Password:  $password");
    developer.log("Confirm Password:  $confirmPassword");
    if (email == "" && password == "" && confirmPassword == "") {
      return false;
    }
    if (password == confirmPassword) {
      ServiceAuth serviceAuth = ServiceAuth();
      return await serviceAuth.signUp(email, password);
    } else {
      return false;
    }
  }
}

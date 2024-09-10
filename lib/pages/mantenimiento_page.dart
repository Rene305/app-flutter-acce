import 'package:flutter/material.dart';

class MantenimientoPage extends StatefulWidget {
  const MantenimientoPage({super.key});

  @override
  State<MantenimientoPage> createState() => _MantenimientoPageState();
}

class _MantenimientoPageState extends State<MantenimientoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página en mantenimiento",
            style: Theme.of(context).textTheme.displayLarge),
      ),
      body: const Center(
        child: Text("La página actual se encuentra en mantenimiento..."),
      ),
    );
  }
}

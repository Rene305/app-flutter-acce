import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aquí puedes reemplazar 'assets/loading.gif' por la ruta de tu GIF
            Image.asset(
              'assets/images/video-start.mp4',
              width: 420.0,
              height: 750.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

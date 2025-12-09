//Pantalla de inicio de sesión - Electromax
//Grupo 8 - TP4

import 'package:flutter/material.dart';

class LoginElectromaxScreen extends StatefulWidget {
  const LoginElectromaxScreen({super.key});

  @override
  _LoginElectromaxScreenState createState() => _LoginElectromaxScreenState();
}

class _LoginElectromaxScreenState extends State<LoginElectromaxScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),

            // ------------------- LOGO ---------------------
            Icon(Icons.electrical_services, size: 90, color: Colors.blueAccent),
            SizedBox(height: 15),
            Text(
              "Electromax",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Bienvenido, inicia sesión para continuar",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),

            SizedBox(height: 40),

            // ------------------- CAMPO CORREO ---------------------
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Correo electrónico",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            // ------------------- CAMPO CONTRASEÑA ---------------------
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Contraseña",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 30),

            // ------------------- BOTÓN DE INICIO DE SESIÓN ---------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/home");
                },
                child: Text(
                  "Iniciar Sesión",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 20),

            // ------------------- ENLACE DE REGISTRO ---------------------
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/registro");
              },
              child: Text(
                "¿No tienes cuenta? Regístrate aquí",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

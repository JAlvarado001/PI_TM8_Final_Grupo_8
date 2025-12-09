// Implemente una pantalla con pestañas para navegar
//entre diferentes categorías utilizando los widgets TabBar y TabBarView
//Grupo 8 - TP4

import 'package:flutter/material.dart';

class HomeElectromaxScreen extends StatelessWidget {
  const HomeElectromaxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text("Electromax"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------- HEADER ---------------------
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.electrical_services,
                    color: Colors.white,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bienvenidos al Mundo Electromax",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Los mejores electrodomésticos y Equipos Electronicos al mejor precio",
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            // --------------------- BOTONES PRINCIPALES ---------------------
            Text(
              "Opciones principales",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(
                  icon: Icons.shopping_cart,
                  label: "Comprar",
                  onTap: () {
                    Navigator.pushNamed(context, "/categorias");
                  },
                ),
                _mainButton(
                  icon: Icons.local_offer,
                  label: "Ofertas",
                  onTap: () {},
                ),
                _mainButton(
                  icon: Icons.support,
                  label: "Soporte",
                  onTap: () {},
                ),
              ],
            ),

            SizedBox(height: 30),

            // --------------------- CATEGORÍAS ---------------------
            Text(
              "Categorías",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            _categoryCard(
              title: "Refrigeración",
              icon: Icons.ac_unit,
              onTap: () {
                Navigator.pushNamed(context, "/categorias");
              },
            ),

            _categoryCard(
              title: "Cocina",
              icon: Icons.local_fire_department,
              onTap: () {
                Navigator.pushNamed(context, "/categorias");
              },
            ),

            _categoryCard(
              title: "Lavado",
              icon: Icons.local_laundry_service,
              onTap: () {
                Navigator.pushNamed(context, "/categorias");
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------
  // Widget para botones principales
  // ---------------------------------------------------
  Widget _mainButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 35, color: Colors.blueAccent),
            SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------
  // Widget para tarjetas de categorías
  // ---------------------------------------------------
  Widget _categoryCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 35, color: Colors.blueAccent),
        title: Text(title, style: TextStyle(fontSize: 18)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}

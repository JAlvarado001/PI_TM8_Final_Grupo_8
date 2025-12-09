// Pantalla de lista de productos para el Cliente
//Grupo 8  - TP4

import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  // Lista de productos a mostar para el Cliente
  final List<Map<String, dynamic>> products = [
    {
      "name": "Nevera Whirlpool",
      "description": "Refrigeradora Top Mount Whirlpool 426L WRM54BKTWW",
      "price": 521.00,
    },
    {
      "name": "Televisor Samsung",
      "description": "Smart TV LED 43'' Samsung 4K UHD",
      "price": 335.50,
    },
    {
      "name": "Computadora Portátil HP",
      "description": "HP 14 Ordenador portátil, Ryzen 3-3250, 4GB RAM",
      "price": 550.99,
    },
    {
      "name": "Tablet Lenovo",
      "description": "Tablet Lenovo 9'' Samsung 4K UHD",
      "price": 135.50,
    },
    {
      "name": "Barra de Sonido LG",
      "description": " Barra de Sonido LG 1200W",
      "price": 220.99,
    },
  ];

  ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Productos")),
      body: Column(
        children: [
          // Agregar el logo en la parte superior
          Image.asset(
            'assets/images/electromaxlogo.jpg',
            width: 180, // Ajusta el tamaño según sea necesario
            height: 180,
          ),
          const SizedBox(height: 20),
          const Text(
            'Bienvenidos al Mundo Electromax',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Lista de productos
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.shopping_bag, color: Colors.blue),
                    title: Text(item["name"]),
                    subtitle: Text(item["description"]),
                    trailing: Text("\$${item["price"].toString()}"),
                    onTap: () {
                      // Acción al tocar el producto
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Seleccionaste: ${item["name"]}"),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

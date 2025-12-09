// Manejo de Eventos de Usuario (Toques y Deslizamientos)
//Johnny Alvarado - CP3

import 'package:flutter/material.dart';

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  String _message = 'Realiza un gesto en la pantalla';

  void _updateMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manejo de Eventos de Usuario (Toques y Deslizamientos)',
        ),
      ),
      body: GestureDetector(
        onTap: () => _updateMessage('Has tocado la pantalla'),
        onDoubleTap: () => _updateMessage('Has hecho doble toque'),
        onLongPress: () => _updateMessage('Has hecho una pulsación larga'),
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            _updateMessage('Deslizando hacia la derecha');
          } else if (details.delta.dx < 0) {
            _updateMessage('Deslizando hacia la izquierda');
          }
        },
        child: Center(
          child: Container(
            color: Colors.grey[200],
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text(
                _message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

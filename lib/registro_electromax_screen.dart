import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Formulario de Registro de Clientes
// Grupo 8 - TP4

class RegistroElectromaxScreen extends StatefulWidget {
  const RegistroElectromaxScreen({super.key});

  @override
  _RegistroElectromaxScreenState createState() =>
      _RegistroElectromaxScreenState(); // ← CORREGIDO
}

class _RegistroElectromaxScreenState extends State<RegistroElectromaxScreen> {
  final TextEditingController cedulaCtrl = TextEditingController();
  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController direccionCtrl = TextEditingController();
  final TextEditingController telefonoCtrl = TextEditingController();
  final TextEditingController ciudadCtrl = TextEditingController();

  bool loading = false;

  final CollectionReference clientesRef = FirebaseFirestore.instance.collection(
    "clientes",
  );

  // ---------------------------------------------------------
  // MÉTODO PARA GUARDAR CLIENTE
  // ---------------------------------------------------------
  Future<void> saveCliente() async {
    if (cedulaCtrl.text.isEmpty ||
        nombreCtrl.text.isEmpty ||
        telefonoCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Complete los campos obligatorios"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    final doc = await clientesRef.doc(cedulaCtrl.text.trim()).get();

    if (doc.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ya existe un cliente con esa cédula"),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => loading = false);
      return;
    }

    final data = {
      "cedula": cedulaCtrl.text.trim(),
      "nombre": nombreCtrl.text.trim().toUpperCase(),
      "direccion": direccionCtrl.text.trim(),
      "telefono": telefonoCtrl.text.trim(),
      "ciudad": ciudadCtrl.text.trim(),
      "fecha": DateTime.now(),
    };

    try {
      await clientesRef.doc(data["cedula"]).set(data);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cliente registrado correctamente"),
          backgroundColor: Colors.green,
        ),
      );

      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al guardar: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => loading = false);
  }

  // ---------------------------------------------------------
  // LIBERAR MEMORIA
  // ---------------------------------------------------------
  @override
  void dispose() {
    cedulaCtrl.dispose();
    nombreCtrl.dispose();
    direccionCtrl.dispose();
    telefonoCtrl.dispose();
    ciudadCtrl.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------
  // UI
  // ---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Registro de Cliente"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.person_add, size: 70, color: Colors.blueAccent),
            const SizedBox(height: 10),
            const Text(
              "Crear Cuenta en Electromax",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            _buildInput(
              "Cédula",
              cedulaCtrl,
              Icons.badge,
              TextInputType.number,
            ),
            const SizedBox(height: 20),

            _buildInput("Nombre completo", nombreCtrl, Icons.person),
            const SizedBox(height: 20),

            _buildInput("Dirección", direccionCtrl, Icons.home),
            const SizedBox(height: 20),

            _buildInput(
              "Teléfono",
              telefonoCtrl,
              Icons.phone,
              TextInputType.phone,
            ),
            const SizedBox(height: 20),

            _buildInput("Ciudad", ciudadCtrl, Icons.location_city),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : saveCliente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Registrar Cliente",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "¿Ya tienes cuenta? Inicia sesión",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // WIDGET REUTILIZABLE
  // ---------------------------------------------------------
  Widget _buildInput(
    String label,
    TextEditingController ctrl,
    IconData icon, [
    TextInputType type = TextInputType.text,
  ]) {
    return TextField(
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

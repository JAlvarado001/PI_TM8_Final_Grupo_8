//Tarea Practica 5
//Implementación de Funcionalidades CRUD para Clientes en una
//aplicación Flutter con Firebase Firestore.
// Johnny Alvarado - Cesar Bustamante
//Grupo 8

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

// ==============================================
// MODELO DE CLIENTE   - ELECTROMAX
// ==============================================
class Cliente {
  String id;
  String cedula;
  String nombre;
  String direccion;
  String telefono;
  String ciudad;
  DateTime fechaRegistro;

  Cliente({
    this.id = '',
    required this.cedula,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.ciudad,
    DateTime? fechaRegistro,
  }) : fechaRegistro = fechaRegistro ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'ciudad': ciudad,
      'fechaRegistro': Timestamp.fromDate(fechaRegistro),
    };
  }

  factory Cliente.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Cliente(
      id: doc.id,
      cedula: data['cedula'],
      nombre: data['nombre'],
      direccion: data['direccion'],
      telefono: data['telefono'],
      ciudad: data['ciudad'],
      fechaRegistro: (data['fechaRegistro'] as Timestamp).toDate(),
    );
  }
}

// ==============================================
// MAIN APP - ELECTROMAX
// ==============================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ElectromaxApp());
}

class ElectromaxApp extends StatelessWidget {
  const ElectromaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Electromax CRUD",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomePage(),
    );
  }
}

// ==============================================
// HOME PAGE CON IMAGEN  - ELECTROMAX
// ==============================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Electromax - Gestión de Clientes")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ------------ IMAGEN ------------
            SizedBox(
              height: 180,
              child: Image.asset(
                "assets/images/electromaxlogo.jpg",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.person_add),
              label: const Text("Formulario CRUD de Clientes Electromax"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ClienteFormScreen()),
                );
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text("Listado de Clientes"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ClienteListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================
// FORMULARIO CRUD - ELECTROMAX
// ==============================================
class ClienteFormScreen extends StatefulWidget {
  const ClienteFormScreen({super.key});

  @override
  State<ClienteFormScreen> createState() => _ClienteFormScreenState();
}

class _ClienteFormScreenState extends State<ClienteFormScreen> {
  final TextEditingController cedulaCtrl = TextEditingController();
  final TextEditingController nombreCtrl = TextEditingController();
  final TextEditingController direccionCtrl = TextEditingController();
  final TextEditingController telefonoCtrl = TextEditingController();
  final TextEditingController ciudadCtrl = TextEditingController();

  final clientesRef = FirebaseFirestore.instance.collection("clientes");

  String? currentId;

  Future<void> crearOActualizar() async {
    if (cedulaCtrl.text.isEmpty || nombreCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cédula y nombre son obligatorios")),
      );
      return;
    }

    final cliente = Cliente(
      cedula: cedulaCtrl.text.trim(),
      nombre: nombreCtrl.text.trim(),
      direccion: direccionCtrl.text.trim(),
      telefono: telefonoCtrl.text.trim(),
      ciudad: ciudadCtrl.text.trim(),
    );

    try {
      if (currentId == null) {
        final q = await clientesRef
            .where("cedula", isEqualTo: cliente.cedula)
            .get();
        if (q.docs.isNotEmpty) {
          currentId = q.docs.first.id;
          await clientesRef.doc(currentId).update(cliente.toMap());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Cliente actualizado")));
        } else {
          await clientesRef.add(cliente.toMap());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Cliente creado")));
        }
      } else {
        await clientesRef.doc(currentId).update(cliente.toMap());
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Cliente actualizado")));
      }
      limpiar();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> buscarPorCedula() async {
    final ced = cedulaCtrl.text.trim();
    if (ced.isEmpty) return;

    final q = await clientesRef.where("cedula", isEqualTo: ced).get();
    if (q.docs.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Cliente no encontrado")));
      return;
    }

    final c = Cliente.fromDoc(q.docs.first);
    setState(() {
      currentId = c.id;
      nombreCtrl.text = c.nombre;
      direccionCtrl.text = c.direccion;
      telefonoCtrl.text = c.telefono;
      ciudadCtrl.text = c.ciudad;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Cliente cargado")));
  }

  Future<void> eliminar() async {
    if (currentId == null) return;

    await clientesRef.doc(currentId).delete();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Cliente eliminado")));
    limpiar();
  }

  void limpiar() {
    setState(() {
      currentId = null;
      cedulaCtrl.clear();
      nombreCtrl.clear();
      direccionCtrl.clear();
      telefonoCtrl.clear();
      ciudadCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario Cliente - Electromax")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: cedulaCtrl,
              decoration: const InputDecoration(labelText: "Cédula"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: buscarPorCedula,
              child: const Text("Buscar Cliente"),
            ),
            const Divider(),
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: direccionCtrl,
              decoration: const InputDecoration(labelText: "Dirección"),
            ),
            TextField(
              controller: telefonoCtrl,
              decoration: const InputDecoration(labelText: "Teléfono"),
            ),
            TextField(
              controller: ciudadCtrl,
              decoration: const InputDecoration(labelText: "Ciudad"),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: crearOActualizar,
              child: Text(
                currentId == null ? "Crear Cliente" : "Actualizar Cliente",
              ),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: eliminar,
              child: const Text("Eliminar Cliente"),
            ),

            const SizedBox(height: 10),
            OutlinedButton(onPressed: limpiar, child: const Text("Limpiar")),
          ],
        ),
      ),
    );
  }
}

// ==============================================
// LISTADO DE CLIENTES - ELECTROMAX
// ==============================================
class ClienteListScreen extends StatelessWidget {
  const ClienteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clientesRef = FirebaseFirestore.instance.collection("clientes");

    return Scaffold(
      appBar: AppBar(title: const Text("Listado de Clientes - Electromax")),
      body: StreamBuilder<QuerySnapshot>(
        stream: clientesRef
            .orderBy("fechaRegistro", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          if (docs.isEmpty)
            return const Center(child: Text("No hay clientes registrados"));

          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              final cliente = Cliente.fromDoc(docs[i]);
              return ListTile(
                title: Text(cliente.nombre),
                subtitle: Text(
                  "Cédula: ${cliente.cedula} - Tel: ${cliente.telefono}",
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_examen_2p/tumbaco_plua_joseph_restaurante.dart';
import 'package:flutter_examen_2p/tumbaco_plua_joseph_platos.dart';
import 'tumbaco_plua_joseph_formulario.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1F2D57)), // Azul oscuro
        useMaterial3: true,
      ),
      home: const PaginaPrincipalPage(title: 'Flutter'),
    );
  }
}

class PaginaPrincipalPage extends StatefulWidget {
  const PaginaPrincipalPage({super.key, required this.title});

  final String title;

  @override
  State<PaginaPrincipalPage> createState() => _PaginaPrincipalPageState();
}

class _PaginaPrincipalPageState extends State<PaginaPrincipalPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color(0xFFE98FB8), // Rosa claro
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.add), label: 'Reserva'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Menú'),
        ],
      ),
      body: [
        const RestauranteScreen(),
        const FormularioScreen(),
        const PlatosScreen()
      ][currentPageIndex],
    );
  }
}

void main() {
  runApp(const MyApp());
}

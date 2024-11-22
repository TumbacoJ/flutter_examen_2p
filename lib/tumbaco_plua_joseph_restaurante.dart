import 'package:flutter/material.dart';

// Define una clase para representar la información de un restaurante.
class Restaurante {
  final String nombre;
  final String ubicacion;
  final String horario;
  final String imagenUrl;

  Restaurante({
    required this.nombre,
    required this.ubicacion,
    required this.horario,
    required this.imagenUrl,
  });
}

// Define una lista de restaurantes de ejemplo.
final List<Restaurante> restaurantes = [
  Restaurante(
    nombre: 'Pims Panecillo',
    ubicacion: 'General Melchor Aymerich Cima del Panecillo, Quito 170111 Ecuador',
    horario: '12:00 AM - 23:00 PM',
    imagenUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/7a/e4/c4/nuestra-especialidad.jpg?w=1200&h=-1&s=1',
  ),
  Restaurante(
    nombre: 'El Rancho de Juancho',
    ubicacion: 'Isla Floreana E5-27 & Isla Isabela, Quito 170150 Ecuador',
    horario: '09:00 AM - 16:30 PM',
    imagenUrl: 'https://lh3.googleusercontent.com/p/AF1QipNgdRHkW-bXKP3jRZQTBSXp0mU5Y1FwhHXf24en=s1360-w1360-h1020', 
  ),
  Restaurante(
    nombre: 'El Patio',
    ubicacion: 'Av. 9 de Octubre 414 Garcia Moreno, Guayaquil 090150 Ecuador',
    horario: '17:30 PM - 00:00 AM',
    imagenUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1a/4b/7c/67/el-patio.jpg?w=1400&h=-1&s=1', 
  ),
];

class RestauranteScreen extends StatelessWidget {
  const RestauranteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurantes'),
      ),
      body: ListView.builder(
        itemCount: restaurantes.length,
        itemBuilder: (context, index) {
          final restaurante = restaurantes[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurante.nombre,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Ubicación: ${restaurante.ubicacion}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Horario: ${restaurante.horario}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Image.network(
                  restaurante.imagenUrl,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: RestauranteScreen(),
  ));
}

import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart' show rootBundle;

class Plato {
  final String nombre;
  final String imagen;
  final String valor;

  Plato({
    required this.nombre,
    required this.imagen,
    required this.valor,
  });
}

class Restaurante {
  final String nombre;
  final List<Plato> platos;

  Restaurante({
    required this.nombre,
    required this.platos,
  });
}

Future<List<Restaurante>> cargarDatos() async {
  final data = await rootBundle.loadString('documento/datos.xml');
  final document = xml.XmlDocument.parse(data);
  final restaurantes = <Restaurante>[];

  for (var xmlRestaurante in document.findAllElements('restaurante')) {
    final nombre = xmlRestaurante.getAttribute('nombre')!;
    final platos = <Plato>[];

    for (var xmlPlato in xmlRestaurante.findElements('plato')) {
      final nombrePlato = xmlPlato.findElements('nombre').single.text;
      final imagen = xmlPlato.findElements('imagen').single.text;
      final valor = xmlPlato.findElements('valor').single.text;

      platos.add(Plato(
        nombre: nombrePlato,
        imagen: imagen,
        valor: valor,
      ));
    }

    restaurantes.add(Restaurante(
      nombre: nombre,
      platos: platos,
    ));
  }

  return restaurantes;
}

class PlatosScreen extends StatelessWidget {
  const PlatosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platos'),
      ),
      body: FutureBuilder<List<Restaurante>>(
        future: cargarDatos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay datos disponibles.'));
          } else {
            final restaurantes = snapshot.data!;

            return ListView.builder(
              itemCount: restaurantes.length,
              itemBuilder: (context, index) {
                final restaurante = restaurantes[index];
                return ExpansionTile(
                  title: Text(restaurante.nombre),
                  children: restaurante.platos.map((plato) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.lightBlueAccent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            plato.nombre,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Image.network(
                            plato.imagen,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Valor: \$${plato.valor}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PlatosScreen(),
  ));
}

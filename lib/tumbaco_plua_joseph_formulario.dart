import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({Key? key}) : super(key: key);

  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> with RestorationMixin {
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  final RestorableInt _numeroPersonas = RestorableInt(1);
  final RestorableStringN _selectedRestaurant = RestorableStringN(null);
  final RestorableBool _isPagoEfectivo = RestorableBool(false);
  final RestorableBool _isPagoTarjeta = RestorableBool(false);

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: DatePickerDialog(
            restorationId: 'date_picker_dialog',
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          ),
        );
      },
    );
  }

  @override
  String? get restorationId => 'formulario_screen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_numeroPersonas, 'numero_personas');
    registerForRestoration(_selectedRestaurant, 'selected_restaurant');
    registerForRestoration(_isPagoEfectivo, 'is_pago_efectivo');
    registerForRestoration(_isPagoTarjeta, 'is_pago_tarjeta');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
      });
    }
  }

  void _save() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Guardado'),
          content: const Text('Guardado Correctamente'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    print('Cédula: ${_cedulaController.text}');
    print('Nombre: ${_nombreController.text}');
    print('Apellido: ${_apellidoController.text}');
    print('Fecha de Reserva: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}');
    print('Número de Personas: ${_numeroPersonas.value}');
    print('Teléfono: ${_telefonoController.text}');
    print('Menú Disponible: ${_selectedRestaurant.value}');
    print('Correo Electrónico: ${_correoController.text}');
    print('Pago Efectivo: ${_isPagoEfectivo.value}');
    print('Pago Tarjeta: ${_isPagoTarjeta.value}');
  }

  void _clear() {
    _cedulaController.clear();
    _nombreController.clear();
    _apellidoController.clear();
    _telefonoController.clear();
    _correoController.clear();
    setState(() {
      _selectedDate.value = DateTime.now();
      _numeroPersonas.value = 1;
      _selectedRestaurant.value = null;
      _isPagoEfectivo.value = false;
      _isPagoTarjeta.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Reserva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _cedulaController,
                decoration: const InputDecoration(
                  labelText: 'Cédula',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _apellidoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Fecha de Reserva: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _restorableDatePickerRouteFuture.present(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Menú Disponible',
                  border: OutlineInputBorder(),
                ),
                value: _selectedRestaurant.value,
                items: <String>['El Patio', 'El Rancho de Juancho', 'Pims Panecillo']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRestaurant.value = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Formato de Pago:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Efectivo'),
                      value: _isPagoEfectivo.value,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPagoEfectivo.value = value!;
                          if (value) {
                            _isPagoTarjeta.value = false;
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Tarjeta de Crédito'),
                      value: _isPagoTarjeta.value,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPagoTarjeta.value = value!;
                          if (value) {
                            _isPagoEfectivo.value = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Número de Personas: ${_numeroPersonas.value}',
                style: const TextStyle(fontSize: 16),
              ),
              Slider(
                value: _numeroPersonas.value.toDouble(),
                min: 1,
                max: 20,
                divisions: 19,
                label: _numeroPersonas.value.toString(),
                onChanged: (double value) {
                  setState(() {
                    _numeroPersonas.value = value.toInt();
                  });
                },
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _save,
                    child: const Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: _clear,
                    child: const Text('Borrar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

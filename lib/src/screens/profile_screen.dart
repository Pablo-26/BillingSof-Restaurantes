import 'package:flutter/material.dart';
import 'package:frontend/src/models/user.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Puedes ajustar el tamaño y estilo de la imagen del perfil si tienes una
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color.fromRGBO(217, 217, 217, 1), // Fondo gris claro
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: const Color.fromRGBO(29, 33, 37, 1)// Color del icono
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${user.firstName} ${user.lastName1} ${user.lastName2}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${user.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'DNI: ${user.dni}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Teléfono: ${user.phone}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Tipo de Vehículo: ${user.vehicleType}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Número de Placa: ${user.numberPlate}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Aquí implementamos la lógica para cerrar sesión
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/start', (route) => false);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(213, 31, 54, 1),
                  iconColor: Colors.white,
                  side: BorderSide.none,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.exit_to_app,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

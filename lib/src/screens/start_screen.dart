import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CarouselSlider(
                items: [
                  _buildCard(
                    'assets/images/bike.png',
                    'Forma parte de nuestra familia de repartidores',
                    'Se el afiliado de confianza de nuestro grupo de repartidores',
                  ),
                  _buildCard(
                    'assets/images/bike.png',
                    'Ten flexibilidad en tu horario',
                    'Trabaja en los horarios a tu conveniencia de manera segura',
                  )
                ],
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    height: 400,
                    autoPlayInterval: const Duration(seconds: 5)),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(213, 31, 54, 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 90,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  'Registrate',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(String image, String title, String description) {
  return Card(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 220,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Color.fromRGBO(167, 169, 183, 1),
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

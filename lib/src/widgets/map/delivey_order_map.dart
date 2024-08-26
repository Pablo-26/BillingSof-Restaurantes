import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/src/models/order.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:whatsapp/whatsapp.dart';

class DeliveyOrderMap extends StatefulWidget {
  final Order order;

  const DeliveyOrderMap({super.key, required this.order});

  @override
  State<DeliveyOrderMap> createState() => _DeliveyOrderMapState();
}

class _DeliveyOrderMapState extends State<DeliveyOrderMap> {
  final locationController = Location();

  // API DE WHATSAPP
  final accessToken =
      'EAAVlRYMD1KMBO4Rsdy06LZBlPJBEpjT5bW9s8a3W7cbwBHLg99miWjPe7pH5MvZBaFrQKT2gdwgskmosNw8CAm3huGqEP2H1vGSyqrMG7VGqrsiDaGfAb7lpYMpCwtDyxZBwKmA99gpLu36o892yJtTREsqRkBtj1oXMgLEruy4B3VvSIbREcU0P3HtU5OCZARXDFIRIR29D4AAcNgWu';
  final fromNumberId = '372192112647400';

  late WhatsApp whatsApp;

  // Coordenadas de destino

  LatLng? currentPosition;
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    whatsApp = WhatsApp(accessToken, fromNumberId);
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await fetchLocationUpdates());
  }

  Future<void> initializeMap() async {
    await fetchLocationUpdates();
    final coordinates = await fetchPolylinePoints();
    generatePolylineFromPoints(coordinates);
  }

  // Detalles de entrega
  void _openOrderDetails() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Estado del repartidor en la entrega
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(167, 169, 183, 1),
                    ),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'En camino al destino',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(29, 39, 47, 1),
                      ),
                    ),
                    Text(
                      'Arribo al destino en aproximado: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(167, 169, 183, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 40),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(167, 169, 183, 1),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.person,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        //Nombre del usuario
                        Text('Juan Perez'),
                        SizedBox(
                          width: 60,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.phone,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.circleDot,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(widget.order.restaurante)
                      ],
                    ),
                    Text('  |'),
                    Text('  |'),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.locationDot,
                          color: Color.fromRGBO(29, 39, 47, 1),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(widget.order.location),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Column(
                        children: [
                          OutlinedButton(
                            onPressed: () => _notifyClient(),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(29, 39, 47, 1),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 17,
                                  horizontal: 60,
                                ),
                                side: BorderSide.none),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.whatsapp),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Notificar Cliente',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color.fromRGBO(29, 39, 47, 1),
                              padding: const EdgeInsets.symmetric(
                                vertical: 17,
                                horizontal: 60,
                              ),
                              side: BorderSide(
                                color: Color.fromRGBO(29, 39, 47, 1),
                                width: 1,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /* FaIcon(
                                  FontAwesomeIcons.flagCheckered,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 20,
                                ), */
                                Text(
                                  'Finalizar Pedido',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _notifyClient() async {
    /*  final whatsapp = WhatsApp(
        'EAAVlRYMD1KMBO4Rsdy06LZBlPJBEpjT5bW9s8a3W7cbwBHLg99miWjPe7pH5MvZBaFrQKT2gdwgskmosNw8CAm3huGqEP2H1vGSyqrMG7VGqrsiDaGfAb7lpYMpCwtDyxZBwKmA99gpLu36o892yJtTREsqRkBtj1oXMgLEruy4B3VvSIbREcU0P3HtU5OCZARXDFIRIR29D4AAcNgWu',
        '+15556181305'); */

    const phoneNumber = '+593995731957'; // Número de teléfono del cliente
    const message = 'El pedido se encuentra listo para ser entregado. El repartidor se encuentre fuera de su domicilio.';

    var res = await whatsApp.sendMessage(
      phoneNumber: phoneNumber,
      text: message,
      previewUrl: true,
    );

    if (res.isSuccess()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mensaje enviado al cliente'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al enviar el mensaje'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Color.fromRGBO(29, 39, 47, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Color.fromRGBO(29, 39, 47, 1),
              size: 40,
            )),
        title: const Text('Detalles de Localización'),
        actions: [
          IconButton(
            onPressed: () => _openOrderDetails(),
            icon: const FaIcon(
              FontAwesomeIcons.ellipsisVertical,
            ),
          ),
        ],
      ),
      body: currentPosition == null
          ? const Center(
              child: Text(
                'Cargando...',
              ),
            )
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: currentPosition!, zoom: 16),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: {
                Marker(
                  markerId: MarkerId('Destino'),
                  position: widget.order.latLng,
                  infoWindow: InfoWindow(title: 'Destino'),
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted == await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
        });
        print(currentPosition);
      }
    });
  }

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
          origin: PointLatLng(
              currentPosition!.latitude, currentPosition!.longitude),
          destination: PointLatLng(widget.order.lat, widget.order.long),
          mode: TravelMode.driving),
      googleApiKey: googleMapsAPIKey,
    );

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
      return [];
    }
  }

  Future<void> generatePolylineFromPoints(
      List<LatLng> polylineCoordinates) async {
    const id = PolylineId('polyline');

    final polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );

    setState(
      () => polylines[id] = polyline,
    );
  }
}

extension on Order {
  LatLng get latLng => LatLng(lat, long);
}

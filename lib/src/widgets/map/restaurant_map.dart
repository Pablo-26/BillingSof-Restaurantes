import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:frontend/src/models/restaurant.dart';

class RestaurantMap extends StatefulWidget {
  final double height;
  final double width;

  const RestaurantMap({super.key, required this.height, required this.width});

  @override
  State<StatefulWidget> createState() {
    return _RestaurantMapState();
  }
}

class _RestaurantMapState extends State<RestaurantMap> {
  Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  final List<Restaurant> _restaurants = [
    Restaurant(
      nombre: 'El Corzo',
      lat: -3.9894194278255823,
      long: -79.19825960882764,
    ),
    Restaurant(
      nombre: 'Pepizza',
      lat: -3.9860887658578563,
      long: -79.20216219436796,
    ),
    Restaurant(
      nombre: 'Cecinas la Y',
      lat: -3.9910052400862925,
      long: -79.1998041053684,
    ),
    Restaurant(
      nombre: 'Morellia Parrilla',
      lat: -3.9918467273552136,
      long: -79.19978581423221,
    ),
    Restaurant(
      nombre: 'Gula Bar',
      lat: -3.956690927339366, 
      long: -79.2137024714467,
    ),
    Restaurant(
      nombre: 'Mirador Restaurante',
      lat: -3.9555919297661988, 
      long: -79.20623647710667,
    ),

  ];

  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then((_) => {
          getPolylinePoints().then((coordinates) {
            generatePolylineFromPoints(coordinates);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: _currentP == null
          ? const Center(
              child: Text('Cargando...'),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _currentP!,
                zoom: 16,
              ),
              markers: _createMarkers(),
              polylines: Set<Polyline>.of(polylines.values),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 16,
    );
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentP!);
        });
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
          origin: PointLatLng(
            _restaurants[0].lat,
            _restaurants[0].long,
          ),
          destination: PointLatLng(
            _restaurants[3].lat,
            _restaurants[3].long,
          ),
          mode: TravelMode.walking),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  Set<Marker> _createMarkers() {
    final markers = _restaurants.map((restaurant) {
      return Marker(
        markerId: MarkerId(restaurant.nombre),
        position: restaurant.latLng,
        infoWindow: InfoWindow(
          title: restaurant.nombre,
        ),
      );
    }).toSet();
    return markers;
  }
}

extension on Restaurant {
  LatLng get latLng => LatLng(lat, long);
}

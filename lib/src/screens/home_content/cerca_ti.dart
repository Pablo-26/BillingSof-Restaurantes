import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/widgets/map/restaurant_map.dart';

class CercaTi extends StatelessWidget {
  CercaTi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RestaurantMap(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.9,
      ),
    );
  }
}

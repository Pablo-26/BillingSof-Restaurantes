import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

final formatter = DateFormat.yMd();

class Order {
  Order({
    required this.nameOrder,
    required this.restaurante,
    required this.status,
    required this.date,
    required this.location,
    required this.lat,
    required this.long
  }): id = uuid.v4();

  final String id;
  final String nameOrder;
  final String restaurante;
  final String status;
  final DateTime date;
  final String location;
  final double lat;
  final double long;

  String get formattedDate {
    return formatter.format(date);
  }
}

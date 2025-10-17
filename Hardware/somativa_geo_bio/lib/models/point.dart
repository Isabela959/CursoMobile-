import 'package:cloud_firestore/cloud_firestore.dart';

class Point {
  String id;
  String userId;
  double latitude;
  double longitude;
  DateTime dataHora;

  Point({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.dataHora,
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'dataHora': dataHora,
    };
  }

  factory Point.fromMap(Map<String, dynamic> map) {
    return Point(
      id: map['id'], 
      userId: map['userId'], 
      latitude: map['latitude'], 
      longitude: map['longitude'],
      dataHora:(map['dataHora'] as Timestamp).toDate(),
    );
  }
}

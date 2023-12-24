// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleOwnerTicketRequestModel {
  final String departure;
  final String arrival;
  final String departTime;
  final String arrivalTime;
  final String meet;
  final String price;
  final String ddob;
  VehicleOwnerTicketRequestModel({
    required this.departure,
    required this.arrival,
    required this.departTime,
    required this.arrivalTime,
    required this.meet,
    required this.price,
    required this.ddob,
  });

  VehicleOwnerTicketRequestModel copyWith({
    String? departure,
    String? arrival,
    String? departTime,
    String? arrivalTime,
    String? meet,
    String? price,
    String? ddob,
  }) {
    return VehicleOwnerTicketRequestModel(
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      departTime: departTime ?? this.departTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      meet: meet ?? this.meet,
      price: price ?? this.price,
      ddob: ddob ?? this.ddob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'departure': departure,
      'arrival': arrival,
      'depart_time': departTime,
      'arrival_time': arrivalTime,
      'meet': meet,
      'price': price,
      'ddob': ddob,
    };
  }

  factory VehicleOwnerTicketRequestModel.fromMap(Map<String, dynamic> map) {
    return VehicleOwnerTicketRequestModel(
      departure: map['departure'] as String,
      arrival: map['arrival'] as String,
      departTime: map['depart_time'] as String,
      arrivalTime: map['arrival_time'] as String,
      meet: map['meet'] as String,
      price: map['price'] as String,
      ddob: map['ddob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleOwnerTicketRequestModel.fromJson(String source) =>
      VehicleOwnerTicketRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VehicleOwnerTicketRequestModel(departure: $departure, arrival: $arrival, depart_time: $departTime, arrival_time: $arrivalTime, meet: $meet, price: $price, ddob: $ddob)';
  }

  @override
  bool operator ==(covariant VehicleOwnerTicketRequestModel other) {
    if (identical(this, other)) return true;

    return other.departure == departure &&
        other.arrival == arrival &&
        other.departTime == departTime &&
        other.arrivalTime == arrivalTime &&
        other.meet == meet &&
        other.price == price &&
        other.ddob == ddob;
  }

  @override
  int get hashCode {
    return departure.hashCode ^
        arrival.hashCode ^
        departTime.hashCode ^
        arrivalTime.hashCode ^
        meet.hashCode ^
        price.hashCode ^
        ddob.hashCode;
  }
}

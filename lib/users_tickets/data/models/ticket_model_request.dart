// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TicketModelRequest {
  final String vehicleType;
  final String departure;
  final String arrival;
  final String dob;
  TicketModelRequest({
    required this.vehicleType,
    required this.departure,
    required this.arrival,
    required this.dob,
  });

  TicketModelRequest copyWith({
    String? vehicleType,
    String? departure,
    String? arrival,
    String? dob,
  }) {
    return TicketModelRequest(
      vehicleType: vehicleType ?? this.vehicleType,
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicle_type': vehicleType,
      'departure': departure,
      'arrival': arrival,
      'dob': dob,
    };
  }

  factory TicketModelRequest.fromMap(Map<String, dynamic> map) {
    return TicketModelRequest(
      vehicleType: map['vehicle_type'] as String,
      departure: map['departure'] as String,
      arrival: map['arrival'] as String,
      dob: map['dob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketModelRequest.fromJson(String source) =>
      TicketModelRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TicketModel(vehicle_type: $vehicleType, departure: $departure, arrival: $arrival, dob: $dob)';
  }

  @override
  bool operator ==(covariant TicketModelRequest other) {
    if (identical(this, other)) return true;

    return other.vehicleType == vehicleType &&
        other.departure == departure &&
        other.arrival == arrival &&
        other.dob == dob;
  }

  @override
  int get hashCode {
    return vehicleType.hashCode ^
        departure.hashCode ^
        arrival.hashCode ^
        dob.hashCode;
  }
}

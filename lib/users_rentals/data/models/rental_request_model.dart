// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RentalRequestModel {
  final String vehicletype;
  final String city;
  final String dob;
  RentalRequestModel({
    required this.vehicletype,
    required this.city,
    required this.dob,
  });

  RentalRequestModel copyWith({
    String? vehicletype,
    String? city,
    String? dob,
  }) {
    return RentalRequestModel(
      vehicletype: vehicletype ?? this.vehicletype,
      city: city ?? this.city,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicle_type': vehicletype,
      'city': city,
      'dob': dob,
    };
  }

  factory RentalRequestModel.fromMap(Map<String, dynamic> map) {
    return RentalRequestModel(
      vehicletype: map['vehicle_type'] as String,
      city: map['city'] as String,
      dob: map['dob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RentalRequestModel.fromJson(String source) =>
      RentalRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RentalRequestModel(vehicle_type: $vehicletype, city: $city, dob: $dob)';

  @override
  bool operator ==(covariant RentalRequestModel other) {
    if (identical(this, other)) return true;

    return other.vehicletype == vehicletype &&
        other.city == city &&
        other.dob == dob;
  }

  @override
  int get hashCode => vehicletype.hashCode ^ city.hashCode ^ dob.hashCode;
}

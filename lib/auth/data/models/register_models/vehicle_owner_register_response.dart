// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleOwnerRegisterResponseModel {
  final String name;
  final String email;
  final String password;
  final String gender;
  final int age;
  final String phoneNumber;
  final String vehicleName;
  final String vehicleType;
  final String vehicleNumber;

  final int vehicleSeat;
  final String location;
  final String dob;
  VehicleOwnerRegisterResponseModel({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.age,
    required this.phoneNumber,
    required this.vehicleName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleSeat,
    required this.location,
    required this.dob,
  });

  VehicleOwnerRegisterResponseModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? gender,
    int? age,
    String? phoneNumber,
    String? vehicleName,
    String? vehicleType,
    String? vehicleNumber,
    int? vehicleSeat,
    String? location,
    String? dob,
  }) {
    return VehicleOwnerRegisterResponseModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      vehicleSeat: vehicleSeat ?? this.vehicleSeat,
      location: location ?? this.location,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'age': age,
      'phoneNumber': phoneNumber,
      'vehicleName': vehicleName,
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'vehicleSeat': vehicleSeat,
      'location': location,
      'dob': dob,
    };
  }

  factory VehicleOwnerRegisterResponseModel.fromMap(Map<String, dynamic> map) {
    return VehicleOwnerRegisterResponseModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
      age: map['age'] as int,
      phoneNumber: map['phoneNumber'] as String,
      vehicleName: map['vehicleName'] as String,
      vehicleType: map['vehicleType'] as String,
      vehicleNumber: map['vehicleNumber'] as String,
      vehicleSeat: map['vehicleSeat'] as int,
      location: map['location'] as String,
      dob: map['dob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleOwnerRegisterResponseModel.fromJson(String source) =>
      VehicleOwnerRegisterResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VehicleOwnerRegisterResponseModel( name: $name, email: $email, password: $password, gender: $gender, age: $age, phoneNumber: $phoneNumber, vehicleName: $vehicleName, vehicleType: $vehicleType, vehicleNumber: $vehicleNumber,  vehicleSeat: $vehicleSeat, location: $location, dob: $dob)';
  }

  @override
  bool operator ==(covariant VehicleOwnerRegisterResponseModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.gender == gender &&
        other.age == age &&
        other.phoneNumber == phoneNumber &&
        other.vehicleName == vehicleName &&
        other.vehicleType == vehicleType &&
        other.vehicleNumber == vehicleNumber &&
        other.vehicleSeat == vehicleSeat &&
        other.location == location &&
        other.dob == dob;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        gender.hashCode ^
        age.hashCode ^
        phoneNumber.hashCode ^
        vehicleName.hashCode ^
        vehicleType.hashCode ^
        vehicleNumber.hashCode ^
        vehicleSeat.hashCode ^
        location.hashCode ^
        dob.hashCode;
  }
}

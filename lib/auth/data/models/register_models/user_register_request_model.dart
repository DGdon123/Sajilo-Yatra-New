// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String gender;
  final int age;
  final String phoneNumber;
  final String location;
  final String dob;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.age,
    required this.phoneNumber,
    required this.location,
    required this.dob,
  });

  RegisterRequestModel copyWith({
    String? name,
    String? email,
    String? password,
    String? gender,
    int? age,
    String? phoneNumber,
    String? location,
    String? dob,
  }) {
    return RegisterRequestModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      phoneNumber: phoneNumber ?? this.phoneNumber,
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
      'location': location,
      'dob': dob,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
      age: map['age'] as int,
      phoneNumber: map['phoneNumber'] as String,
      location: map['location'] as String,
      dob: map['dob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterRequestModel(name: $name, email: $email, password: $password, gender: $gender, age: $age, phoneNumber: $phoneNumber, location: $location, dob: $dob)';
  }

  @override
  bool operator ==(covariant RegisterRequestModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.gender == gender &&
        other.age == age &&
        other.phoneNumber == phoneNumber &&
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
        location.hashCode ^
        dob.hashCode;
  }
}

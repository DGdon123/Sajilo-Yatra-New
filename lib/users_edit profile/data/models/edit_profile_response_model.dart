// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EditProfileResponseModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String location;
  final String dob;
  EditProfileResponseModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.location,
    required this.dob,
  });

  EditProfileResponseModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? location,
    String? dob,
  }) {
    return EditProfileResponseModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'location': location,
      'dob': dob,
    };
  }

  factory EditProfileResponseModel.fromMap(Map<String, dynamic> map) {
    return EditProfileResponseModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      location: map['location'] as String,
      dob: map['dob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileResponseModel.fromJson(String source) =>
      EditProfileResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EditProfileResponseModel(name: $name, email: $email, phoneNumber: $phoneNumber, location: $location, dob: $dob)';
  }

  @override
  bool operator ==(covariant EditProfileResponseModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.location == location &&
        other.dob == dob;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        location.hashCode ^
        dob.hashCode;
  }
}

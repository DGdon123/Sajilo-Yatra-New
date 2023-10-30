// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProfileResponseModel {
  final String id;
  final String name;
  final String email;
  final String gender;
  final int age;
  final String phone;
  final String location;
  final String dob;
  ProfileResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.age,
    required this.phone,
    required this.location,
    required this.dob,
  });
  

  ProfileResponseModel copyWith({
    String? id,
    String? name,
    String? email,
    String? gender,
    int? age,
    String? phone,
    String? location,
    String? dob,
  }) {
    return ProfileResponseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'age': age,
      'phone': phone,
      'location': location,
      'dob': dob,
    };
  }

  factory ProfileResponseModel.fromMap(Map<String, dynamic> map) {
    return ProfileResponseModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      age: map['age'] as int,
      phone: map['phone'] as String,
      location: map['location'] as String,
      dob: map['dob'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileResponseModel.fromJson(String source) => ProfileResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileResponseModel(id: $id, name: $name, email: $email, gender: $gender, age: $age, phone: $phone, location: $location, dob: $dob)';
  }

  @override
  bool operator ==(covariant ProfileResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.gender == gender &&
      other.age == age &&
      other.phone == phone &&
      other.location == location &&
      other.dob == dob;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      age.hashCode ^
      phone.hashCode ^
      location.hashCode ^
      dob.hashCode;
  }
}

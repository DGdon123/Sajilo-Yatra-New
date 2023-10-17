// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponseModel {
  final String id;
  final String name;
  final String email;
  final String token;
  LoginResponseModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  LoginResponseModel copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
  }) {
    return LoginResponseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponseModel(_id: $id, name: $name, email: $email, token: $token)';
  }

  @override
  bool operator ==(covariant LoginResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ token.hashCode;
  }
}

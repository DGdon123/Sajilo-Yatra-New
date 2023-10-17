// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleOwnerForgotPasswordRequestModel {
  final String email;
  VehicleOwnerForgotPasswordRequestModel({
    required this.email,
  });

  VehicleOwnerForgotPasswordRequestModel copyWith({
    String? email,
  }) {
    return VehicleOwnerForgotPasswordRequestModel(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory VehicleOwnerForgotPasswordRequestModel.fromMap(
      Map<String, dynamic> map) {
    return VehicleOwnerForgotPasswordRequestModel(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleOwnerForgotPasswordRequestModel.fromJson(String source) =>
      VehicleOwnerForgotPasswordRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForgotPasswordRequestModel(email: $email)';

  @override
  bool operator ==(covariant VehicleOwnerForgotPasswordRequestModel other) {
    if (identical(this, other)) return true;

    return other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleOwnerResetPasswordRequestModel {
  final String password;
  VehicleOwnerResetPasswordRequestModel({
    required this.password,
  });

  VehicleOwnerResetPasswordRequestModel copyWith({
    String? password,
  }) {
    return VehicleOwnerResetPasswordRequestModel(
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
    };
  }

  factory VehicleOwnerResetPasswordRequestModel.fromMap(
      Map<String, dynamic> map) {
    return VehicleOwnerResetPasswordRequestModel(
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleOwnerResetPasswordRequestModel.fromJson(String source) =>
      VehicleOwnerResetPasswordRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResetPasswordRequestModel(password: $password)';

  @override
  bool operator ==(covariant VehicleOwnerResetPasswordRequestModel other) {
    if (identical(this, other)) return true;

    return other.password == password;
  }

  @override
  int get hashCode => password.hashCode;
}

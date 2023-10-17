// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleOwnerForgotPasswordResponseModel {
  final String message;
  VehicleOwnerForgotPasswordResponseModel({
    required this.message,
  });

  VehicleOwnerForgotPasswordResponseModel copyWith({
    String? message,
  }) {
    return VehicleOwnerForgotPasswordResponseModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory VehicleOwnerForgotPasswordResponseModel.fromMap(
      Map<String, dynamic> map) {
    return VehicleOwnerForgotPasswordResponseModel(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleOwnerForgotPasswordResponseModel.fromJson(String source) =>
      VehicleOwnerForgotPasswordResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForgotPasswordResponseModel(message: $message)';

  @override
  bool operator ==(covariant VehicleOwnerForgotPasswordResponseModel other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

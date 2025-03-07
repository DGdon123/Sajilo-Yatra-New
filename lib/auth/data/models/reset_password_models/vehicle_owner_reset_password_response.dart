// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleOwnerResetPasswordResponseModel {
  final String message;
  VehicleOwnerResetPasswordResponseModel({
    required this.message,
  });

  VehicleOwnerResetPasswordResponseModel copyWith({
    String? message,
  }) {
    return VehicleOwnerResetPasswordResponseModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory VehicleOwnerResetPasswordResponseModel.fromMap(
      Map<String, dynamic> map) {
    return VehicleOwnerResetPasswordResponseModel(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleOwnerResetPasswordResponseModel.fromJson(String source) =>
      VehicleOwnerResetPasswordResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResetPasswordResponseModel(message: $message)';

  @override
  bool operator ==(covariant VehicleOwnerResetPasswordResponseModel other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

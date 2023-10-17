// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ForgotPasswordResponseModel {
  final String message;
  ForgotPasswordResponseModel({
    required this.message,
  });
  

  ForgotPasswordResponseModel copyWith({
    String? message,
  }) {
    return ForgotPasswordResponseModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory ForgotPasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordResponseModel(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordResponseModel.fromJson(String source) => ForgotPasswordResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForgotPasswordResponseModel(message: $message)';

  @override
  bool operator ==(covariant ForgotPasswordResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResetPasswordResponseModel {
  final String message;
  ResetPasswordResponseModel({
    required this.message,
  });

  ResetPasswordResponseModel copyWith({
    String? message,
  }) {
    return ResetPasswordResponseModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory ResetPasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordResponseModel(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordResponseModel.fromJson(String source) => ResetPasswordResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResetPasswordResponseModel(message: $message)';

  @override
  bool operator ==(covariant ResetPasswordResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

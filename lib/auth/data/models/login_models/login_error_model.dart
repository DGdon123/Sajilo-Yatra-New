// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginErrorModel {
  final String message;
  LoginErrorModel({
    required this.message,
  });

  LoginErrorModel copyWith({
    String? message,
  }) {
    return LoginErrorModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory LoginErrorModel.fromMap(Map<String, dynamic> map) {
    return LoginErrorModel(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginErrorModel.fromJson(String source) => LoginErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginErrorModel(message: $message)';

  @override
  bool operator ==(covariant LoginErrorModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

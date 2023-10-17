// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ForgotPasswordRequestModel {
  final String email;
  ForgotPasswordRequestModel({
    required this.email,
  });
  

  ForgotPasswordRequestModel copyWith({
    String? email,
  }) {
    return ForgotPasswordRequestModel(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory ForgotPasswordRequestModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordRequestModel(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordRequestModel.fromJson(String source) => ForgotPasswordRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForgotPasswordRequestModel(email: $email)';

  @override
  bool operator ==(covariant ForgotPasswordRequestModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

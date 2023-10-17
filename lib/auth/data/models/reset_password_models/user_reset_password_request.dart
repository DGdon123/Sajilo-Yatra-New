// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResetPasswordRequestModel {
  final String password;
  ResetPasswordRequestModel({
    required this.password,
  });

  ResetPasswordRequestModel copyWith({
    String? password,
  }) {
    return ResetPasswordRequestModel(
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
    };
  }

  factory ResetPasswordRequestModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordRequestModel(
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordRequestModel.fromJson(String source) =>
      ResetPasswordRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResetPasswordRequestModel(password: $password)';

  @override
  bool operator ==(covariant ResetPasswordRequestModel other) {
    if (identical(this, other)) return true;

    return other.password == password;
  }

  @override
  int get hashCode => password.hashCode;
}

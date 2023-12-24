// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProfileParams {
  final String token;
  ProfileParams({
    required this.token,
  });

  ProfileParams copyWith({
    String? token,
  }) {
    return ProfileParams(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory ProfileParams.fromMap(Map<String, dynamic> map) {
    return ProfileParams(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileParams.fromJson(String source) =>
      ProfileParams.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProfileParams(token: $token)';

  @override
  bool operator ==(covariant ProfileParams other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}

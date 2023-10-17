// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Express {
  final String express;
  Express({
    required this.express,
  });

  Express copyWith({
    String? express,
  }) {
    return Express(
      express: express ?? this.express,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'express': express,
    };
  }

  factory Express.fromMap(Map<String, dynamic> map) {
    return Express(
      express: map['express'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Express.fromJson(String source) =>
      Express.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Express(express: $express)';

  @override
  bool operator ==(covariant Express other) {
    if (identical(this, other)) return true;

    return other.express == express;
  }

  @override
  int get hashCode => express.hashCode;
}

import 'package:repository/model/model.dart';

class User extends Entity {
  final String id;
  final String name;
  final String email;

  User({
    this.id,
    this.name,
    this.email,
  });

  // ignore: prefer_constructors_over_static_methods
  static User fromJson(dynamic json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  List<Object> get props => [id, name, email];

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

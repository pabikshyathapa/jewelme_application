import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? filepath; // profile image path, optional

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.filepath,
  });

  @override
  List<Object?> get props => [id, name, email, phone, filepath];

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      filepath: json['filepath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "filepath": filepath,
    };
  }
}

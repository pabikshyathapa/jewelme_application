import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? userId;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? password;

  const UserEntity({
    this.userId,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
  });
  
  @override
  List<Object?> get props => [
    userId,
    fullname,
    email,
    phone,
    password,
  ];
  }
import 'package:flutter/widgets.dart';

@immutable
sealed class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent{
  final BuildContext context;
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterUserEvent({
    required this.context,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}
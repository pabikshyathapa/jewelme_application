import 'package:flutter/material.dart';

@immutable
sealed class LoginEvent {}

class NavigateToRegisterViewEvent extends LoginEvent {
  final BuildContext context;

  NavigateToRegisterViewEvent({required this.context});
}

class NavigateToHomeViewEvent extends LoginEvent {
  final BuildContext context;

  NavigateToHomeViewEvent({required this.context});
}

class LoginWithEmailAndPasswordEvent extends LoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  LoginWithEmailAndPasswordEvent({
    required this.context,
    required this.email,
    required this.password,
  });
}

// class LoginWithEmailAndPasswordEvent extends LoginEvent {
//   final String email;
//   final String password;
//   final BuildContext? context; // Make it optional

//   LoginWithEmailAndPasswordEvent({
//     required this.email,
//     required this.password,
//     this.context,
//   });
// }


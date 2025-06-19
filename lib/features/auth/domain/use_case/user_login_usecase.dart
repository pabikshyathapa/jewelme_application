import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/auth/domain/repository/user_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  // Initial Constructor
  const LoginParams.initial() : email = '', password = '';
  @override
  List<Object?> get props => [email, password];
}

class UserLoginUsecase implements UsecaseWithParams<String, LoginParams> {
  final IuserRepository _userRepository;

  UserLoginUsecase({required IuserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await _userRepository.loginUser(
     params.email,
     params.password,
     );
  }

 
}

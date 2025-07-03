import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/auth/domain/repository/user_repository.dart';

class RegisterUseParams extends Equatable{
  final String name;
  final String email;
  final String phone;
  final String password;

  const RegisterUseParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
    //initial constructer
    const RegisterUseParams.initial({
      required this.name,
      required this.email,
      required this.phone,
      required this.password
    });
  
  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    password,
  ];

}
class UserRegisterUsecase implements UsecaseWithParams<void,RegisterUseParams>{
  final IuserRepository _userRepository;
  UserRegisterUsecase({required IuserRepository userRepository})
  :_userRepository=userRepository;
  
  @override
  Future<Either<Failure, void>> call(RegisterUseParams params) {
      
    final userEntity=UserEntity(
      name: params.name,
     email:params.email,
      phone:params.phone, 
      password:params.password,
      );
      return _userRepository.registerUser(userEntity);
  }
  }


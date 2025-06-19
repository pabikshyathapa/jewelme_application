import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/auth/domain/repository/user_repository.dart';

class RegisterUseParams extends Equatable{
  final String fullname;
  final String email;
  final String phone;
  final String password;

  const RegisterUseParams({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
  });
    //initial constructer
    const RegisterUseParams.initial({
      required this.fullname,
      required this.email,
      required this.phone,
      required this.password
    });
  
  @override
  List<Object?> get props => [
    fullname,
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
      fullname: params.fullname,
     email:params.email,
      phone:params.phone, 
      password:params.password,
      );
      return _userRepository.registerUser(userEntity);
  }
  }


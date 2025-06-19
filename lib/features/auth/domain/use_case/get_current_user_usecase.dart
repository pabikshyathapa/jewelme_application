import 'package:dartz/dartz.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/auth/domain/repository/user_repository.dart';

class UserGetCurrentUserUsecase implements UsecaseWithoutParams<UserEntity> {
  final IuserRepository _iuserRepository;

  UserGetCurrentUserUsecase({required IuserRepository userRepository})
  : _iuserRepository=userRepository;

  @override
  Future<Either<Failure, UserEntity>> call() {
    return _iuserRepository.getCurrentUser();
  }
  
} 
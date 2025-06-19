import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';

abstract interface class IuserRepository{
  Future <Either<Failure, void>> registerUser(UserEntity user);
  
  Future <Either<Failure, String>> loginUser(String email, String password);

  Future<Either<Failure, UserEntity>> getCurrentUser();

}
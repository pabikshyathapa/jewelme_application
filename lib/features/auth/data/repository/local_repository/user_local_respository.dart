import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/auth/domain/repository/user_repository.dart';

class UserLocalRespository implements IuserRepository{
  final UserLocalDatasource _userLocalDatasource;

  UserLocalRespository({
    required UserLocalDatasource userLocalDatasource,
  }): _userLocalDatasource=userLocalDatasource;

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
   try{
    await _userLocalDatasource.registerUser(user);
    return Right(null);
   }catch (e){
    return Left(LocalDatabaseFailure(message: "Failed to Register:$e"));
   }

  }
  
  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, String>> loginUser(
    String email, 
    String password,
    )async {
    try {
      final result = await _userLocalDatasource.loginUser(
        email,
        password,
      );
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to login: $e"));
    }
  }

  }

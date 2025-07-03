import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/auth/domain/repository/user_repository.dart';

class UserRemoteRepository implements IuserRepository{
  final UserRemoteDatasource _userRemoteDatasource;
   UserRemoteRepository({
    required UserRemoteDatasource userRemoteDataSource,
   }): _userRemoteDatasource=userRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) async{
  try {
      final token = await _userRemoteDatasource.loginUser(
        email,
        password,
      );
      return Right(token);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }


  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async{
    try {
      await _userRemoteDatasource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

}
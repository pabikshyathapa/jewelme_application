import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/profile/data/data_source/user_datasource.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/domain/repository/user_repository.dart';


class IUserRemoteRepository implements IUserRepository {
  final IUserDataSource _userremoteDataSource;

  IUserRemoteRepository({
    required IUserDataSource userremoteDataSource,
  }) : _userremoteDataSource = userremoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String userId) async {
    try {
      final result = await _userremoteDataSource.getUserProfile(userId);
      return result;
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

 @override
@override
Future<Either<Failure, UserEntity>> updateUserProfile(
  String userId,
  UserEntity updatedUser,
) async {
  try {
    final result = await _userremoteDataSource.updateUserProfile(
      userId,
      updatedUser,
    );
    return result;
  } catch (e) {
    return Left(RemoteDatabaseFailure(message: e.toString()));
  }
}
}

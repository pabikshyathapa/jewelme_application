import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jewelme_application/app/constant/api_endpoints.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/core/network/api_sevice.dart';
import 'package:jewelme_application/features/profile/data/data_source/user_datasource.dart';
import 'package:jewelme_application/features/profile/data/model/user_api_model.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';

class UserremoteDataSource implements IUserDataSource {
  final ApiService _apiService;

  UserremoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String userId) async {
    try {
      final response = await _apiService.dio.get(
        ApiEndpoints.getUserById(userId),
      );

      if (response.statusCode == 200) {
        final userJson = response.data['data'];
        final user = UserApiModel.fromJson(userJson).toEntity();
        return Right(user);
      } else {
        return Left(RemoteDatabaseFailure(
          message: response.statusMessage ?? 'Failed to fetch user profile',
        ));
      }
    } on DioException catch (e) {
      return Left(RemoteDatabaseFailure(message: e.message ?? 'Dio error'));
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserProfile(
    String userId,
    UserEntity updatedUser,
  ) async {
    try {
      final response = await _apiService.dio.put(
        ApiEndpoints.updateUserById(userId),
        data: UserApiModel.fromEntity(updatedUser).toJson(),
      );

      if (response.statusCode == 200) {
        final userJson = response.data['data'];
        final user = UserApiModel.fromJson(userJson).toEntity();
        return Right(user);
      } else {
        return Left(RemoteDatabaseFailure(
          message: response.statusMessage ?? 'Failed to update user profile',
        ));
      }
    } on DioException catch (e) {
      return Left(RemoteDatabaseFailure(message: e.message ?? 'Dio error'));
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}

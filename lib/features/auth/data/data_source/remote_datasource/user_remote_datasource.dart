// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:jewelme_application/app/constant/api_endpoints.dart';
import 'package:jewelme_application/core/network/api_sevice.dart';
import 'package:jewelme_application/features/auth/data/data_source/user_data_source.dart';
import 'package:jewelme_application/features/auth/data/model/user_api_model.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';


class UserRemoteDatasource implements IuserDataSource {
  final ApiService _apiService;

  UserRemoteDatasource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final token = response.data['token'];
        return token;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to login user: ${e.message}');
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
  }

  @override
  Future<void> registerUser(UserEntity userData) async {
    try {
      final userApiModel = UserApiModel.fromEntity(userData);
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: userApiModel.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception(
          'Failed to register user: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to register user: ${e.message}');
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  // @override
  // Future<UserEntity> getCurrentUser() {
  //   throw UnimplementedError();
  // }
} 
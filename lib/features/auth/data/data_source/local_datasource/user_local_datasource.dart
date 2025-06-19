import 'package:jewelme_application/core/network/hive_service.dart';
import 'package:jewelme_application/features/auth/data/data_source/user_data_source.dart';
import 'package:jewelme_application/features/auth/data/model/user_hive_model.dart';
import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';

class UserLocalDatasource implements IuserDataSource{
  final HiveService _hiveService;

  UserLocalDatasource({required HiveService hiveservice})
  :_hiveService=hiveservice;

@override
  Future<String> loginUser(String email, String password) async {
    try {
      final userData = await _hiveService.loginUser(email, password);
      if (userData != null && userData.password == password) {
        return "Login successful";
      } else {
        throw Exception("Invalid username or password");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }
  @override
  Future<void> registerUser(UserEntity userData)async {
    try{
      final userHiveModel=UserHiveModel.fromEntity(userData);
      await _hiveService.register(userHiveModel);
    }catch(e){
      throw Exception("Registration Failed:$e");

    }
  }}
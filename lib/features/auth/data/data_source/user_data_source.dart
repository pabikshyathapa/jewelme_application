import 'package:jewelme_application/features/auth/domain/entity/user_entity.dart';

abstract interface class IuserDataSource{
  Future<void> registerUser (UserEntity userData);
}
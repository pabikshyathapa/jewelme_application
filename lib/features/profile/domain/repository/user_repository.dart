import 'package:dartz/dartz.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';

abstract interface class IUserRepository {
  /// Get the currently logged-in user's profile info
  Future<Either<Failure, UserEntity>> getUserProfile(String userId);

  /// Update the logged-in user's profile info
  Future<Either<Failure, UserEntity>> updateUserProfile(
    String userId,
    UserEntity updatedUser,
  );
}

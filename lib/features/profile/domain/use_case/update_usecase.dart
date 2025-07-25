import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/domain/repository/user_repository.dart';

class UpdateUserProfileUseParams extends Equatable {
  final String userId;
  final UserEntity updatedUser;

  const UpdateUserProfileUseParams({
    required this.userId,
    required this.updatedUser,
  });

  @override
  List<Object?> get props => [userId, updatedUser];
}
class UpdateUserProfileUsecase implements UsecaseWithParams<UserEntity, UpdateUserProfileUseParams> {
  final IUserRepository _userRepository;

  UpdateUserProfileUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, UserEntity>> call(UpdateUserProfileUseParams params) {
    return _userRepository.updateUserProfile(params.userId, params.updatedUser);
  }
}
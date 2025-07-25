import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jewelme_application/app/use_case/use_case.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/domain/repository/user_repository.dart';

class GetUserProfileUseParams extends Equatable {
  final String userId;

  const GetUserProfileUseParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetUserProfileUsecase implements UsecaseWithParams<UserEntity, GetUserProfileUseParams> {
  final IUserRepository _userRepository;

  GetUserProfileUsecase({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, UserEntity>> call(GetUserProfileUseParams params) {
    return _userRepository.getUserProfile(params.userId);
  }
}
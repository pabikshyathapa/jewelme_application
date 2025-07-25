import 'package:equatable/equatable.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';

class UserState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final UserEntity? user; // current user profile

  const UserState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
    this.user,
  });

  const UserState.initial()
      : isLoading = false,
        isSuccess = false,
        errorMessage = null,
        user = null;

  UserState copyWith({
  bool? isLoading,
  bool? isSuccess,
  bool clearSuccess = false,
  String? errorMessage,
  bool clearErrorMessage = false,
  UserEntity? user,
}) {
  return UserState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: clearSuccess ? false : isSuccess ?? this.isSuccess,
    errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    user: user ?? this.user,
  );
}

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, user];
}

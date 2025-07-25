import 'package:flutter/widgets.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';

@immutable
sealed class UserEvent {}

/// Event to fetch user profile by user ID
class GetUserProfileEvent extends UserEvent {
  final BuildContext context;
  final String userId;

  GetUserProfileEvent({
    required this.context,
    required this.userId,
  });
}

/// Event to update user profile with new data
class UpdateUserProfileEvent extends UserEvent {
  final BuildContext context;
  final String userId;
  final UserEntity updatedUser;  // import your UserEntity here

  UpdateUserProfileEvent({
    required this.context,
    required this.userId,
    required this.updatedUser,
  });
}
class ClearUserMessageEvent extends UserEvent {}


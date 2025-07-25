import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/features/profile/domain/use_case/getuser_usecase.dart';
import 'package:jewelme_application/features/profile/domain/use_case/update_usecase.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_event.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_state.dart';

class UserViewModel extends Bloc<UserEvent, UserState> {
  final GetUserProfileUsecase _getUserProfileUsecase;
  final UpdateUserProfileUsecase _updateUserProfileUsecase;

  UserViewModel({
    required GetUserProfileUsecase getUserProfileUsecase,
    required UpdateUserProfileUsecase updateUserProfileUsecase,
  })  : _getUserProfileUsecase = getUserProfileUsecase,
        _updateUserProfileUsecase = updateUserProfileUsecase,
        super(const UserState.initial()) {
    on<GetUserProfileEvent>(_onGetUserProfile);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);

    // Added handler to clear success and error messages
    on<ClearUserMessageEvent>((event, emit) {
      emit(state.copyWith(
        isSuccess: false,
        errorMessage: null,
      ));
    });
  }

  Future<void> _onGetUserProfile(
    GetUserProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
    final result = await _getUserProfileUsecase(
      GetUserProfileUseParams(userId: event.userId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
          user: null,
        ));
        showMySnackBar(
          context: event.context,
          message: 'Failed to load profile: ${failure.message}',
          color: Colors.red,
        );
      },
      (user) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          user: user,
          errorMessage: null,
        ));
      },
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfileEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    final result = await _updateUserProfileUsecase(
      UpdateUserProfileUseParams(
        userId: event.userId,
        updatedUser: event.updatedUser,
      ),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ));
        showMySnackBar(
          context: event.context,
          message: 'Failed to update profile: ${failure.message}',
          color: Colors.red,
        );
      },
      (updatedUser) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          user: updatedUser,
          errorMessage: null,
        ));
        showMySnackBar(
          context: event.context,
          message: 'Profile updated successfully!',
          color: Colors.green,
        );

        // Reset success flag to prevent repeated success messages
        emit(state.copyWith(clearSuccess: true));
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
// import 'package:jewelme_application/features/profile/domain/use_case/getuser_usecase.dart';
// import 'package:jewelme_application/features/profile/domain/use_case/update_usecase.dart';
// import 'package:jewelme_application/features/profile/presenttaion/view_model/user_event.dart';
// import 'package:jewelme_application/features/profile/presenttaion/view_model/user_state.dart';

// class UserViewModel extends Bloc<UserEvent, UserState> {
//   final GetUserProfileUsecase _getUserProfileUsecase;
//   final UpdateUserProfileUsecase _updateUserProfileUsecase;

//   UserViewModel({
//     required GetUserProfileUsecase getUserProfileUsecase,
//     required UpdateUserProfileUsecase updateUserProfileUsecase,
//   })  : _getUserProfileUsecase = getUserProfileUsecase,
//         _updateUserProfileUsecase = updateUserProfileUsecase,
//         super(const UserState.initial()) {
//     on<GetUserProfileEvent>(_onGetUserProfile);
//     on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    
//   }

//   Future<void> _onGetUserProfile(
//     GetUserProfileEvent event,
//     Emitter<UserState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));
//     final result = await _getUserProfileUsecase(
//       GetUserProfileUseParams(userId: event.userId),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(
//           isLoading: false,
//           isSuccess: false,
//           errorMessage: failure.message,
//           user: null,
//         ));
//         showMySnackBar(
//           context: event.context,
//           message: 'Failed to load profile: ${failure.message}',
//           color: Colors.red,
//         );
//       },
//       (user) {
//         emit(state.copyWith(
//           isLoading: false,
//           isSuccess: true,
//           user: user,
//           errorMessage: null,
//         ));
//       },
//     );
//   }

//   Future<void> _onUpdateUserProfile(
//     UpdateUserProfileEvent event,
//     Emitter<UserState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

//     final result = await _updateUserProfileUsecase(
//       UpdateUserProfileUseParams(
//         userId: event.userId,
//         updatedUser: event.updatedUser,
//       ),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(
//           isLoading: false,
//           isSuccess: false,
//           errorMessage: failure.message,
//         ));
//         showMySnackBar(
//           context: event.context,
//           message: 'Failed to update profile: ${failure.message}',
//           color: Colors.red,
//         );
//       },
//       (updatedUser) {
//         emit(state.copyWith(
//           isLoading: false,
//           isSuccess: true,
//           user: updatedUser,
//           errorMessage: null,
//         ));
//         showMySnackBar(
//           context: event.context,
//           message: 'Profile updated successfully!',
//           color: Colors.green,
//         );

        
//     emit(state.copyWith(clearSuccess: true));
//       },
//     );
//   }
// }

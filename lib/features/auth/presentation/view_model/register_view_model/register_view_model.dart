import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_state.dart';

class RegisterViewModel  extends Bloc<RegisterEvent, RegisterState>{
  final UserRegisterUsecase _registerUsecase;
  
  RegisterViewModel({
    required UserRegisterUsecase registerUsecase,


  }) : _registerUsecase = registerUsecase,
  super(RegisterState.initial()){
    on<RegisterUserEvent>(_registerUserEvent);
  }

  Future<void> _registerUserEvent(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  )async{
    emit(state.copyWith(isLoading: true));
    final result = await _registerUsecase(
      RegisterUseParams(
      name: event.name,
      email : event.email,
      phone: event.phone,
      password: event.password,

      )
    );

    result.fold(
      (failure){
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Failed to register : ${failure.message}',
          color: Colors.red,

        );
      },
      

      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: ' Registered successful!',

        );

      },
    );
    
  }
}
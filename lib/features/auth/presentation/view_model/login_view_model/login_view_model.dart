import 'package:jewelme_application/core/utils/user_session.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/app/service_locator/service_locator.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:jewelme_application/features/auth/presentation/view/dashboard_page.dart';
import 'package:jewelme_application/features/auth/presentation/view/signup_page.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUsecase _userLoginUsecase;

  LoginViewModel(this._userLoginUsecase) : super(LoginState.initial()) {
    on<NavigateToRegisterViewEvent>(_onNavigateToRegisterView);
    on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
  }

  void _onNavigateToRegisterView(
    NavigateToRegisterViewEvent event,
    Emitter<LoginState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: serviceLocator<RegisterViewModel>()),
            ],
            child: SignUpScreen(),
          ),
        ),
      );
    }
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userLoginUsecase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Invalid credentials. Please try again.',
          color: Colors.red,
        );
      },
      (token) {
        //  Decode JWT and store userId
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        String userId = decodedToken["_id"];
        UserSession.instance.userId = userId;
        print("Logged in user ID: $userId");

        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Login Successful",
          color: Colors.green,
        );

        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (_) => DashboardPage(),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jewelme_application/app/service_locator/service_locator.dart';
// import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
// import 'package:jewelme_application/features/auth/domain/use_case/user_login_usecase.dart';
// import 'package:jewelme_application/features/auth/presentation/view/dashboard_page.dart';
// import 'package:jewelme_application/features/auth/presentation/view/signup_page.dart';
// import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_event.dart';
// import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_state.dart';
// import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

// class LoginViewModel extends Bloc<LoginEvent, LoginState> {
//   final UserLoginUsecase _userLoginUsecase;

//   LoginViewModel(this._userLoginUsecase)
//       : super(LoginState.initial()) {
//     on<NavigateToRegisterViewEvent>(_onNavigateToRegisterView);
//     on<LoginWithEmailAndPasswordEvent>(_onLoginWithEmailAndPassword);
//   }

//   void _onNavigateToRegisterView(
//     NavigateToRegisterViewEvent event,
//     Emitter<LoginState> emit,
//   ) {
//     if (event.context.mounted) {
//       Navigator.push(
//         event.context,
//         MaterialPageRoute(
//           builder: (context) => MultiBlocProvider(
//             providers: [
//               BlocProvider.value(value: serviceLocator<RegisterViewModel>()),
//             ],
//             child: SignUpScreen(),
//           ),
//         ),
//       );
//     }
//   }

//   void _onLoginWithEmailAndPassword(
//     LoginWithEmailAndPasswordEvent event,
//     Emitter<LoginState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _userLoginUsecase(
//       LoginParams(email: event.email, password: event.password),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, isSuccess: false));
//         showMySnackBar(
//           context: event.context,
//           message: 'Invalid credentials. Please try again.',
//           color: Colors.red,
//         );
//       },
//       (token) {
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//         showMySnackBar(
//           context: event.context,
//           message: "Login Successful",
//           color: Colors.green,
//         );
//         Navigator.pushReplacement(
//           event.context,
//           MaterialPageRoute(
//             builder: (_) => DashboardPage(),
//           ),
//         );
//         // Optional: Navigate to Home after login
//         // add(NavigateToHomeViewEvent(context: event.context));
//       },
//     );
//   }
// }


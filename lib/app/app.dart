import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/app/service_locator/service_locator.dart';
import 'package:jewelme_application/app/theme/theme_data.dart';
import 'package:jewelme_application/features/auth/presentation/view/dashboard_page.dart';
import 'package:jewelme_application/features/auth/presentation/view/login_page.dart';
import 'package:jewelme_application/features/auth/presentation/view/signup_page.dart';
import 'package:jewelme_application/features/auth/presentation/view/splashscreen.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:jewelme_application/features/home/presentation/view/home_page.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_view_model.dart';


class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
   Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider<RegisterViewModel>(
      create: (_) => serviceLocator<RegisterViewModel>(),
    ),
    BlocProvider<LoginViewModel>(
      create: (_) => serviceLocator<LoginViewModel>(),
    ),
    BlocProvider<ProductViewModel>(
      create: (_) => serviceLocator<ProductViewModel>(),
    ),
  ],
      child: MaterialApp(
        // title: 'Student Management',
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        home: DashboardPage(), // or your LoginPage
      ),
    );
  }
}
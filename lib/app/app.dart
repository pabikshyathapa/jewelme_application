import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelme_application/app/service_locator/service_locator.dart';
import 'package:jewelme_application/app/theme/theme_data.dart';
import 'package:jewelme_application/features/auth/presentation/view/login_page.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_view_model.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_view_model.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_view_model.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_view_model.dart';


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
    BlocProvider<CartViewModel>(
      create: (_) => serviceLocator<CartViewModel>(),
    ),
    BlocProvider<WishlistViewModel>(
      create: (_) => serviceLocator<WishlistViewModel>(),
    ),
    BlocProvider<OrderViewModel>(
      create: (_) => serviceLocator<OrderViewModel>(),
    ),
     BlocProvider<UserViewModel>(
      create: (_) => serviceLocator<UserViewModel>(),
    ),
  ],
      child: MaterialApp(
        // title: 'Student Management',
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        home: LoginPage(), // or your LoginPage
      ),
    );
  }
}
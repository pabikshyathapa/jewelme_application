import 'package:get_it/get_it.dart';
import 'package:jewelme_application/core/network/hive_service.dart';
import 'package:jewelme_application/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:jewelme_application/features/auth/data/repository/local_repository/user_local_respository.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // First register HiveService
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());

  // Then initialize Hive
  await serviceLocator<HiveService>().init();

  // After Hive is ready, initialize auth module
  await _initAuthModule();
}

Future<void> _initAuthModule() async {
  // Data Source
  serviceLocator.registerFactory(
    () => UserLocalDatasource(hiveservice: serviceLocator<HiveService>()),
  );

  // Repository
  serviceLocator.registerFactory(
    () => UserLocalRespository(
      userLocalDatasource: serviceLocator<UserLocalDatasource>(),
    ),
  );

  // UseCases
  serviceLocator.registerFactory(
    () => UserRegisterUsecase(
      userRepository: serviceLocator<UserLocalRespository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLoginUsecase(
      userRepository: serviceLocator<UserLocalRespository>(),
    ),
  );

  // ViewModels
  serviceLocator.registerLazySingleton(
    () => RegisterViewModel(
      registerUsecase: serviceLocator<UserRegisterUsecase>(),
    ),
  );

  serviceLocator.registerFactory(
    () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
  );
}

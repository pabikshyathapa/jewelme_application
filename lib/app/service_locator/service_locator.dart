import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jewelme_application/core/network/api_sevice.dart';
import 'package:jewelme_application/core/network/hive_service.dart';
import 'package:jewelme_application/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:jewelme_application/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:jewelme_application/features/auth/data/repository/local_repository/user_local_respository.dart';
import 'package:jewelme_application/features/auth/data/repository/remote_repository/user_remote_repository.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:jewelme_application/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jewelme_application/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:jewelme_application/features/home/data/data_source/remote_datasource/product_remote_datesource.dart';
import 'package:jewelme_application/features/home/data/repository/remote_repository/product_remote_repository.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';
import 'package:jewelme_application/features/home/domain/use_case/delete_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/fetchall_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/product_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/update_usecase.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiModule();
  await _initAuthModule();
  await _initProductModule(); 

}
Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initApiModule() async {
  // Dio instance
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  // Register ApiService with Dio injected
  serviceLocator.registerLazySingleton(() => ApiService(serviceLocator<Dio>()));
}

Future<void> _initAuthModule() async {
  // Data Source
  serviceLocator.registerFactory(
    () => UserLocalDatasource(hiveservice: serviceLocator<HiveService>()),
  );

  

  serviceLocator.registerFactory(
    () => UserRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  // Repository
  serviceLocator.registerFactory(
    () => UserLocalRespository(
      userLocalDatasource: serviceLocator<UserLocalDatasource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserRemoteRepository(
      userRemoteDataSource: serviceLocator<UserRemoteDatasource>(),
    ),
  );

  // UseCases
  serviceLocator.registerFactory(
    () => UserRegisterUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLoginUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
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

Future<void> _initProductModule() async {
  // Data Sources
  // serviceLocator.registerFactory(
  //   () => ProductLocalDatasource(hiveService: serviceLocator<HiveService>()),
  // );

  serviceLocator.registerFactory(
    () => ProductRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  // Repository
  serviceLocator.registerFactory<IProductRepository>(
    () => ProductRemoteRepository(
      productRemoteDatasource: serviceLocator<ProductRemoteDatasource>(),
    ),
  );

  // Use Cases
  serviceLocator.registerFactory(
    () => AddProductUsecase(
      productRepository: serviceLocator<IProductRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UpdateProductUsecase(
      productRepository: serviceLocator<IProductRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => DeleteProductUsecase(
      productRepository: serviceLocator<IProductRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => FetchAllProductsUsecase(
      productRepository: serviceLocator<IProductRepository>(),
    ),
  );

  // ViewModels
  serviceLocator.registerFactory(
    () => ProductViewModel(
      addProductUsecase: serviceLocator<AddProductUsecase>(),
      updateProductUsecase: serviceLocator<UpdateProductUsecase>(),
      deleteProductUsecase: serviceLocator<DeleteProductUsecase>(),
      fetchAllProductsUsecase: serviceLocator<FetchAllProductsUsecase>(),
    ),
  );
}

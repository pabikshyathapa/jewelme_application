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
import 'package:jewelme_application/features/cart/data/data_source/cart_data_source.dart';
import 'package:jewelme_application/features/cart/data/data_source/remote_datasource/cart_remote_datasource.dart';
import 'package:jewelme_application/features/cart/data/repository/remote_repository/cart_remote_repository.dart';
import 'package:jewelme_application/features/cart/domain/repository/cart_repository.dart';
import 'package:jewelme_application/features/cart/domain/use_case/addcart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/fetch_cart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/remove_cart_usecase.dart';
import 'package:jewelme_application/features/cart/domain/use_case/update_cart_usecase.dart';
import 'package:jewelme_application/features/cart/presentation/view_model/cart_view_model.dart';
import 'package:jewelme_application/features/home/data/data_source/remote_datasource/product_remote_datesource.dart';
import 'package:jewelme_application/features/home/data/repository/remote_repository/product_remote_repository.dart';
import 'package:jewelme_application/features/home/domain/repository/product_repository.dart';
import 'package:jewelme_application/features/home/domain/use_case/delete_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/fetchall_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/product_usecase.dart';
import 'package:jewelme_application/features/home/domain/use_case/update_usecase.dart';
import 'package:jewelme_application/features/home/presentation/view_model/product_view_model.dart';
import 'package:jewelme_application/features/order/data/data_source/order_datasource.dart';
import 'package:jewelme_application/features/order/data/data_source/remote_datasource/order_remote_datasource.dart';
import 'package:jewelme_application/features/order/data/repository/remote_repository/order_remote_repository.dart';
import 'package:jewelme_application/features/order/domain/repository/order_repository.dart';
import 'package:jewelme_application/features/order/domain/use_case/checkout_usecase.dart';
import 'package:jewelme_application/features/order/domain/use_case/get_userby_id_usecase.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_view_model.dart';
import 'package:jewelme_application/features/profile/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:jewelme_application/features/profile/data/data_source/user_datasource.dart';
import 'package:jewelme_application/features/profile/data/repository/remote_repository/user_remote_repository.dart';
import 'package:jewelme_application/features/profile/domain/repository/user_repository.dart';
import 'package:jewelme_application/features/profile/domain/use_case/getuser_usecase.dart';
import 'package:jewelme_application/features/profile/domain/use_case/update_usecase.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_view_model.dart';
import 'package:jewelme_application/features/wishlist/data/data_source/remote_datasource/wishlist_remote_datasource.dart';
import 'package:jewelme_application/features/wishlist/data/data_source/wishlist_data_source.dart';
import 'package:jewelme_application/features/wishlist/data/repository/remote_repository/wishlist_remote_repository.dart';
import 'package:jewelme_application/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:jewelme_application/features/wishlist/domain/use_case/add_wishlist_usecase.dart';
import 'package:jewelme_application/features/wishlist/domain/use_case/fetch_wishlist_usecase.dart';
import 'package:jewelme_application/features/wishlist/domain/use_case/remove_wishlist_usecase.dart';
import 'package:jewelme_application/features/wishlist/presenttaion/view_model/wishlist_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiModule();
  await _initAuthModule();
  await _initProductModule(); 
  await _initCartModule(); 
  await _initWishlistModule(); 
  await _initOrderModule();
  await _initUserModule();

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

Future<void> _initCartModule() async {

  serviceLocator.registerFactory<ICartDataSource>(
    () => CartRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  
  serviceLocator.registerFactory<ICartRepository>(
    () => CartRemoteRepository(
      cartRemoteDatasource: serviceLocator<ICartDataSource>(),
    ),
  );

 
  serviceLocator.registerFactory(
    () => AddToCartUsecase(
      cartRepository: serviceLocator<ICartRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => RemoveCartItemUseCase(
       serviceLocator<ICartRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UpdateCartQuantityUseCase(
       serviceLocator<ICartRepository>(),
    ),
  );
serviceLocator.registerFactory(
    () => FetchCartUsecase(cartRepository: 
       serviceLocator<ICartRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => ClearCartUsecase(cartRepository: 
       serviceLocator<ICartRepository>(),
    ),
  );


  serviceLocator.registerLazySingleton(
    () => CartViewModel(
      addToCartUsecase: serviceLocator<AddToCartUsecase>(),
      removeCartItemUsecase: serviceLocator<RemoveCartItemUseCase>(),
      updateCartItemQuantityUsecase: serviceLocator<UpdateCartQuantityUseCase>(),
       fetchCartUseCase: serviceLocator<FetchCartUsecase>(), 
       clearCartUsecase: serviceLocator<ClearCartUsecase>(),
    ),
  );
}

Future<void> _initWishlistModule() async {
  serviceLocator.registerFactory<IWishlistDataSource>(
    () => WishlistRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerFactory<IWishlistRepository>(
    () => WishlistRemoteRepository(
      wishlistRemoteDataSource: serviceLocator<IWishlistDataSource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => AddToWishlistUsecase(
      wishlistRepository: serviceLocator<IWishlistRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => RemoveWishlistItemUseCase(
      serviceLocator<IWishlistRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => FetchWishlistUsecase(
      wishlistRepository: serviceLocator<IWishlistRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => WishlistViewModel(
      addToWishlistUsecase: serviceLocator<AddToWishlistUsecase>(),
      removeWishlistItemUsecase: serviceLocator<RemoveWishlistItemUseCase>(),
      fetchWishlistUsecase: serviceLocator<FetchWishlistUsecase>(),
    ),
  );
}

  Future<void> _initOrderModule() async {

  serviceLocator.registerFactory<IOrderDataSource>(
    () => OrderRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerFactory<IOrderRepository>(
    () => OrderRemoteRepository(
      orderRemoteDataSource: serviceLocator<IOrderDataSource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => CheckoutCartUsecase(
      orderRepository: serviceLocator<IOrderRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetOrdersByUserUsecase(
      orderRepository: serviceLocator<IOrderRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => OrderViewModel(
      checkoutCartUsecase: serviceLocator<CheckoutCartUsecase>(),
      getOrdersByUserUsecase: serviceLocator<GetOrdersByUserUsecase>(),
    ),
  );
}



Future<void> _initUserModule() async {
  serviceLocator.registerFactory<IUserDataSource>(
    () => UserremoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  serviceLocator.registerFactory<IUserRepository>(
    () => IUserRemoteRepository(
      userremoteDataSource: serviceLocator<IUserDataSource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetUserProfileUsecase(
      userRepository: serviceLocator<IUserRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UpdateUserProfileUsecase(
      userRepository: serviceLocator<IUserRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => UserViewModel(
      getUserProfileUsecase: serviceLocator<GetUserProfileUsecase>(),
      updateUserProfileUsecase: serviceLocator<UpdateUserProfileUsecase>(),
    ),
  );
}

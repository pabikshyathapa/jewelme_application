import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jewelme_application/app/constant/api_endpoints.dart';
import 'package:jewelme_application/core/error/failure.dart';
import 'package:jewelme_application/core/network/api_sevice.dart';
import 'package:jewelme_application/features/order/data/data_source/order_datasource.dart';
import 'package:jewelme_application/features/order/data/model/order_api_model.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';

class OrderRemoteDataSource implements IOrderDataSource {
  final ApiService _apiService;

  OrderRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Failure, OrderEntity>> checkoutCart(String userId) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.checkoutCart, // e.g. '/api/orders/checkout'
        data: {'userId': userId},
      );

      if (response.statusCode == 200) {
        final orderJson = response.data['data'];
        final order = OrderApiModel.fromJson(orderJson).toEntity();
        return Right(order);
      } else {
        return Left(RemoteDatabaseFailure(
          message: response.statusMessage ?? 'Checkout failed',
        ));
      }
    } on DioException catch (e) {
      return Left(RemoteDatabaseFailure(message: e.message ?? 'Dio error'));
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrdersByUser(
      String userId) async {
    try {
      final response =
          await _apiService.dio.get('${ApiEndpoints.getOrdersByUser}/$userId');

      if (response.statusCode == 200) {
        final List<dynamic> orderListJson = response.data['data'];

        final orders = orderListJson
            .map((json) => OrderApiModel.fromJson(json).toEntity())
            .toList();

        return Right(orders);
      } else {
        return Left(RemoteDatabaseFailure(
          message: response.statusMessage ?? 'Failed to fetch orders',
        ));
      }
    } on DioException catch (e) {
      return Left(RemoteDatabaseFailure(message: e.message ?? 'Dio error'));
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}

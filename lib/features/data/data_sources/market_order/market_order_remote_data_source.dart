import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/customer/base_api_result_model.dart';
import '../../models/market/orders_result_model.dart';

part 'market_order_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketOrderRemoteDataSource {
  factory MarketOrderRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketOrderRemoteDataSource;

  static const _apiUrlPrefix = "Order";

  @GET("$_apiUrlPrefix/GetOrders")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrdersResultModel> getOrders(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetOrderSummary")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getOrderSummary(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetPostOrderSummary")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getPostOrderSummary(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetOrderDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getOrderDetail(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/ApproveOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> approveOrder(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/RejectOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> rejectOrder(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/PrepareOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> prepareOrder(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/ReturnedOrderApprove")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> returnedOrderApprove(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetReturnOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getReturnOrder(
    @Header("token") String token,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/older_orders_result_model.dart';
import '../../models/order_detail_result_model.dart';
import '../../models/order_result_model.dart';

part 'customer_order_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerOrderRemoteDataSource {
  factory CustomerOrderRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerOrderRemoteDataSource;

  static const _apiUrlPrefix = "customer/Order";

  @GET("$_apiUrlPrefix/Save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrderResultModel> save(
    @Header("token") String token,
    @Query("paymentType") int paymentType,
  );

  @GET("$_apiUrlPrefix/Cancel")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> cancel(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/Returned")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> returned(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/Rate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> rate(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetOlderOrders")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OlderOrdersResultModel> getOlderOrders(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrderDetailResultModel> getDetail(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/getPayment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getPayment(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/AddToBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addToBasket(
    @Header("token") String token,
    @Query("Id") String id,
  );
}

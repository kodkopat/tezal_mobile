import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';

part 'customer_order_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerOrderRemoteDataSource {
  factory CustomerOrderRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerOrderRemoteDataSource;

  static const _apiUrlPrefix = "customer/Order";

  @GET("$_apiUrlPrefix/Save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> save(
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
  Future<dynamic> getOlderOrders(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getDetail(
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

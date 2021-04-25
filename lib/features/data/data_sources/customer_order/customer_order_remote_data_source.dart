import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/older_orders_result_model.dart';
import '../../models/order_detail_result_model.dart';
import '../../models/order_result_model.dart';

part 'customer_order_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerOrderRemoteDataSource {
  factory CustomerOrderRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerOrderRemoteDataSource;

  @GET("Order/Save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrderResultModel> save(
    @Header("token") String token,
    @Query("paymentType") int paymentType,
    @Query("AddressId") String addressId,
  );

  @GET("Order/Cancel")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> cancel(
    @Header("token") String token,
  );

  @GET("Order/Returned")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> returned(
    @Header("token") String token,
  );

  @GET("Order/Rate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> rate(
    @Header("token") String token,
  );

  @GET("Order/GetOlderOrders")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OlderOrdersResultModel> getOlderOrders(
    @Header("token") String token,
    @Header("page") int page,
  );

  @GET("Order/GetDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrderDetailResultModel> getDetail(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("Order/getPayment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getPayment(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("Order/AddToBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> addToBasket(
    @Header("token") String token,
    @Query("Id") String id,
  );
}

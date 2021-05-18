import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/customer/older_orders_result_model.dart';
import '../../models/customer/order_detail_result_model.dart';
import '../../models/customer/order_result_model.dart';

part 'customer_order_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerOrderRemoteDataSource {
  factory CustomerOrderRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerOrderRemoteDataSource;

  static const _apiUrlPrefix = "Order";

  @GET("$_apiUrlPrefix/Save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrderResultModel> save(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("paymentType") int paymentType,
    @Query("AddressId") String addressId,
    @Query("deliveryTime") String deliveryTime,
  );

  @GET("$_apiUrlPrefix/CancelOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> cancel(
    @Header("lang") String lang,
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/Returned")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> returned(
    @Header("lang") String lang,
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/Rate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> rate(
    @Header("lang") String lang,
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetOlderOrders")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OlderOrdersResultModel> getOlderOrders(
    @Header("lang") String lang,
    @Header("token") String token,
    @Header("page") int page,
  );

  @GET("$_apiUrlPrefix/GetDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrderDetailResultModel> getDetail(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/getPayment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getPayment(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/AddToBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> addToBasket(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );
}

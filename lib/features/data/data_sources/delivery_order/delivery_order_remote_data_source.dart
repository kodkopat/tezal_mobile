import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';

part 'delivery_order_remote_data_source.g.dart';

@RestApi(baseUrl: deliveryBaseApiUrl)
abstract class DeliveryOrderRemoteDataSource {
  factory DeliveryOrderRemoteDataSource(Dio dio, {String? baseUrl}) =
      _DeliveryOrderRemoteDataSource;

  static const _apiUrlPrefix = "Order";

  @GET("$_apiUrlPrefix/getDeliveryOrders")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getDeliveryOrders(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("orderStatus") int orderStatus,
    @Query("orderbyDistanceDescending") bool orderbyDistanceDescending,
    @Query("orderbyCreateDate") bool orderbyCreateDate,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @GET("$_apiUrlPrefix/TakeOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> takeOrder(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/DeliverOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> deliverOrder(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );
}

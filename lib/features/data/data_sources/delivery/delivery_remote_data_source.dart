import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';

part 'delivery_remote_data_source.g.dart';

@RestApi(baseUrl: deliveryBaseApiUrl)
abstract class DeliveryRemoteDataSource {
  factory DeliveryRemoteDataSource(Dio dio, {String? baseUrl}) =
      _DeliveryRemoteDataSource;

  static const _apiUrlPrefix = "Delivery";

  @GET("$_apiUrlPrefix/SetAvailablity")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> setAvailablity(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("available") bool available,
  );

  @GET("$_apiUrlPrefix/SetLocation")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> setLocation(
    @Header("lang") String lang,
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @GET("DeliveryCenter/List")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> list(
    @Header("lang") String lang,
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("PageSize") int pageSize,
    @Query("Page") int page,
    @Query("OrderBy") String orderBy,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';

part 'market_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketRemoteDataSource {
  factory MarketRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketRemoteDataSource;

  static const _apiUrlPrefix = "Market";

  @POST("$_apiUrlPrefix/Save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> save(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Field() String id,
    @Field() String name,
    @Field() String phone,
    @Field() String telephone,
    @Field() String email,
    @Field() String address,
  );

  @GET("$_apiUrlPrefix/GetCustomerProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getCustomerProfile(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @POST("$_apiUrlPrefix/ChangeMarketProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> changeMarketProfile(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Field() String id,
    @Field() String name,
    @Field() String phone,
    @Field() String telephone,
    @Field() String email,
    @Field() String address,
  );

  @POST("$_apiUrlPrefix/OpenCloseMarket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> openCloseMarket(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @POST("$_apiUrlPrefix/UpdateMarketDefaultHours")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> updateMarketDefaultHours(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @GET("$_apiUrlPrefix/GetMarketDefaultHours")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getMarketDefaultHours(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @POST("$_apiUrlPrefix/GetMarketPhotos")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getMarketPhotos(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("photoId") String photoId,
    @Query("take") int take,
    @Query("skip") int skip,
  );

  @POST("$_apiUrlPrefix/AddMarketPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addMarketPhoto(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Field("photo") String photo,
  );

  @DELETE("$_apiUrlPrefix/RemoveMarketPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> removeMarketPhoto(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("photoId") String photoId,
  );
}

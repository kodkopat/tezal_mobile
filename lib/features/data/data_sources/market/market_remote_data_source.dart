import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';

part 'market_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketRemoteDataSource {
  factory MarketRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketRemoteDataSource;

  static const _apiUrlPrefix = "Market";

  @GET("$_apiUrlPrefix/GetMarketProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getMarketProfile(
    @Header("token") String token,
  );

  @POST("$_apiUrlPrefix/ChangeMarketProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> changeMarketProfile(
    @Header("token") String token,
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
  );

  @POST("$_apiUrlPrefix/UpdateMarketDefaultHours")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> updateMarketDefaultHours(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetMarketDefaultHours")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getMarketDefaultHours(
    @Header("token") String token,
  );

  @POST("$_apiUrlPrefix/GetMarketPhotos")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getMarketPhotos(
    @Header("token") String token,
    @Query("photoId") String photoId,
    @Query("take") int take,
    @Query("skip") int skip,
  );

  @POST("$_apiUrlPrefix/AddMarketPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addMarketPhoto(
    @Header("token") String token,
    @Field("photo") String photo,
  );

  @DELETE("$_apiUrlPrefix/RemoveMarketPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> removeMarketPhoto(
    @Header("token") String token,
    @Query("photoId") String photoId,
  );

  @GET("$_apiUrlPrefix/GetMarketComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getMarketComments(
    @Header("token") String token,
    @Query("orderId") String orderId,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/ReplyMarketComment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> replyMarketComment(
    @Header("token") String token,
    @Field("commentId") String commentId,
    @Field("reply") String reply,
  );
}

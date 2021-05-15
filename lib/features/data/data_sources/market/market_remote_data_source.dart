import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/market/add_photo_result_model.dart';
import '../../models/market/market_comments_result_model.dart';
import '../../models/market/market_default_hours_result_model.dart';
import '../../models/market/market_photos_result_model.dart';
import '../../models/market/market_profile_result_model.dart';
import '../../models/market/update_market_default_hours_model.dart';
import '../../models/photo_result_model.dart';

part 'market_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketRemoteDataSource {
  factory MarketRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketRemoteDataSource;

  static const _apiUrlPrefix = "Market";

  @GET("$_apiUrlPrefix/GetMarketProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketProfileResultModel> getMarketProfile(
    @Header("token") String token,
  );

  @POST("$_apiUrlPrefix/ChangeMarketProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> changeMarketProfile(
    @Header("token") String token,
    @Field() String? id,
    @Field() String? name,
    @Field() String? phone,
    @Field() String? telephone,
    @Field() String? email,
    @Field() String? address,
    @Field() String? shabaNumber,
    @Field() bool? isOpen,
  );

  @POST("$_apiUrlPrefix/OpenCloseMarket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> openCloseMarket(
    @Header("token") String token,
  );

  @POST("$_apiUrlPrefix/UpdateMarketDefaultHours")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> updateMarketDefaultHours(
    @Header("token") String token,
    @Body() List<UpdateMarketDefaultHoursModel> defaultHours,
  );

  @GET("$_apiUrlPrefix/GetMarketDefaultHours")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketDefaultHoursResultModel> getMarketDefaultHours(
    @Header("token") String token,
  );

  @POST("$_apiUrlPrefix/GetMarketPhotos")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketPhotosResultModel> getMarketPhotos(
    @Header("token") String token,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/GetMarketPhotos")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getMarketPhoto(
    @Header("token") String token,
    @Query("photoId") String photoId,
  );

  @POST("$_apiUrlPrefix/AddMarketPhoto")
  @Headers({"Content-Type": "multipart/form-data", "Accept": "text/plain"})
  Future<AddPhotoResultModel> addMarketPhoto(
    @Header("token") String token,
    @Part() File photo,
  );

  @DELETE("$_apiUrlPrefix/RemoveMarketPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> removeMarketPhoto(
    @Header("token") String token,
    @Query("photoId") String photoId,
  );

  @POST("$_apiUrlPrefix/ReOrderMarketPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> reOrderMarketPhoto(
    @Header("token") String token,
    @Body() Map<String, int> photosList,
  );

  @GET("$_apiUrlPrefix/GetMarketComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketCommentsResultModel> getMarketComments(
    @Header("token") String token,
    /* @Query("orderId") String orderId, */
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/ReplyMarketComment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> replyMarketComment(
    @Header("token") String token,
    @Field("commentId") String commentId,
    @Field("reply") String reply,
  );
}

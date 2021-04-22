import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/comments_result_model.dart';
import '../../models/main_category_detail_result_model.dart';
import '../../models/market_detail_result_model.dart';
import '../../models/nearby_markets_result_model.dart';
import '../../models/photos_result_model.dart';
import '../../models/sub_category_detail_result_model.dart';

part 'customer_market_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerMarketRemoteDataSource {
  factory CustomerMarketRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerMarketRemoteDataSource;

  @GET("GetNearByMarkets")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<NearByMarketsResultModel> getNearByMarkets(
    @Header("token") String token,
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("maxDistance") int maxDistance,
    @Query("page") int page,
  );

  @GET("UpdateNearByMarkets")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> updateNearByMarkets(
    @Header("token") String token,
  );

  @GET("GetMarketDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketDetailResultModel> getMarketDetail(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotosResultModel> getPhoto(
    @Query("Id") String id,
  );

  @GET("GetComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CommentsResultModel> getListComment(
    @Query("MarketId") String marketId,
    @Query("Page") int page,
  );

  @GET("AddComment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addComment(
    @Field() String comment,
    @Field() int point,
    @Field() String marketId,
  );

  @GET("GetMainCategoryDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoryDetailResultModel> getMainCategoryDetail(
    @Header("token") String token,
    @Query("MarketId") String marketId,
    @Query("MainCategoryId") String mainCategoryId,
  );

  @GET("GetSubCategoryDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryDetailResultModel> getSubCategoryDetail(
    @Header("token") String token,
    @Query("MarketId") String marketId,
    @Query("SubCategoryId") String subCategoryId,
    @Query("Page") int page,
  );
}

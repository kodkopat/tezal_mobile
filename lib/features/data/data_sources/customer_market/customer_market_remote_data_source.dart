import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/customer/base_api_result_model.dart';
import '../../models/customer/comments_result_model.dart';
import '../../models/customer/main_category_detail_result_model.dart';
import '../../models/customer/market_detail_result_model.dart';
import '../../models/customer/nearby_markets_result_model.dart';
import '../../models/customer/photos_result_model.dart';
import '../../models/customer/sub_category_detail_result_model.dart';

part 'customer_market_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerMarketRemoteDataSource {
  factory CustomerMarketRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerMarketRemoteDataSource;

  @GET("Market/GetNearByMarkets")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<NearByMarketsResultModel> getNearByMarkets(
    @Header("token") String token,
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("maxDistance") int maxDistance,
    @Query("page") int page,
  );

  @GET("Market/UpdateNearByMarkets")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> updateNearByMarkets(
    @Header("token") String token,
  );

  @GET("Market/GetMarketDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketDetailResultModel> getMarketDetail(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("Market/GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotosResultModel> getPhoto(
    @Query("Id") String id,
  );

  @GET("Market/GetComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CommentsResultModel> getListComment(
    @Query("MarketId") String marketId,
    @Query("Page") int page,
  );

  @GET("Market/AddComment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addComment(
    @Field() String comment,
    @Field() int point,
    @Field() String marketId,
  );

  @GET("Market/GetMainCategoryDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoryDetailResultModel> getMainCategoryDetail(
    @Header("token") String token,
    @Query("MarketId") String marketId,
    @Query("MainCategoryId") String mainCategoryId,
  );

  @GET("Market/GetSubCategoryDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryDetailResultModel> getSubCategoryDetail(
    @Header("token") String token,
    @Query("MarketId") String marketId,
    @Query("SubCategoryId") String subCategoryId,
    @Query("Page") int page,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/customer/add_edit_comment_rate_result_model.dart';
import '../../models/customer/comments_result_model.dart';
import '../../models/customer/main_category_detail_result_model.dart';
import '../../models/customer/market_categories_result_model.dart';
import '../../models/customer/market_detail_result_model.dart';
import '../../models/customer/nearby_markets_result_model.dart';
import '../../models/customer/photos_result_model.dart';
import '../../models/customer/sub_category_detail_result_model.dart';

part 'customer_market_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerMarketRemoteDataSource {
  factory CustomerMarketRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerMarketRemoteDataSource;

  static const _apiUrlPrefix = "Market";

  @GET("$_apiUrlPrefix/Like")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> like(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("marketId") String marketId,
  );

  @GET("$_apiUrlPrefix/GetMarketCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketCategoriesResultModel> getMarketCategories(
    @Header("lang") String? lang,
    @Header("token") String? token,
  );

  @GET("$_apiUrlPrefix/GetMarketCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<List<int>> getMarketCategoryPhoto(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("MarketCategoryId") String marketCategoryId,
  );

  @GET("$_apiUrlPrefix/GetNearByMarkets")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<NearByMarketsResultModel> getNearByMarkets(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("maxDistance") int maxDistance,
  );

  @GET("$_apiUrlPrefix/UpdateNearByMarkets")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> updateNearByMarkets(
    @Header("lang") String? lang,
    @Header("token") String? token,
  );

  @GET("$_apiUrlPrefix/GetMarketDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketDetailResultModel> getMarketDetail(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CommentsResultModel> getComments(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("MarketId") String marketId,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/AddEditCommentRate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AddEditCommentRateResultModel> addEditCommentRate(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Field() String comment,
    @Field() String orderId,
    @Field() int rate,
  );

  @GET("$_apiUrlPrefix/GetMainCategoryDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoryDetailResultModel> getMainCategoryDetail(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("MarketId") String marketId,
    @Query("MainCategoryId") String mainCategoryId,
  );

  @GET("$_apiUrlPrefix/GetSubCategoryDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryDetailResultModel> getSubCategoryDetail(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("MarketId") String marketId,
    @Query("SubCategoryId") String subCategoryId,
    @Query("Page") int page,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/comments_result_model.dart';
import '../../models/market_categories_result_model.dart';
import '../../models/market_detail_result_model.dart';
import '../../models/nearby_markets_result_model.dart';
import '../../models/photos_result_model.dart';

part 'customer_market_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerMarketRemoteDataSource {
  factory CustomerMarketRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerMarketRemoteDataSource;

  static const _apiUrlPrefix = "customer/Market";

  @GET("$_apiUrlPrefix/GetNearByMarkets")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<NearByMarketsResultModel> getNearByMarkets(
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("maxDistance") int maxDistance,
    @Query("count") int count,
  );

  @GET("$_apiUrlPrefix/GetMarketDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketDetailResultModel> getMarketDetail(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotosResultModel> getPhoto(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetMarketCategorys")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketCategoriesResultModel> getMarketCategories(
    @Query("MarketId") String marketId,
  );

  @GET("$_apiUrlPrefix/GetComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CommentsResultModel> getListComment(
    @Query("MarketId") String marketId,
    @Query("Page") int page,
  );

  @GET("$_apiUrlPrefix/AddComment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addComment(
    @Field() String comment,
    @Field() int point,
    @Field() String marketId,
  );
}

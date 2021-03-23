import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/market_detail_result_model.dart';
import '../../models/nearby_markets_result_model.dart';
import '../../models/photo_result_model.dart';
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
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getPhoto(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetPhotos")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotosResultModel> getPhotos(
    @Query("Id") String id,
  );
}

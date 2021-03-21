import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../models/market_detail_result_model.dart';
import '../models/nearby_markets_result_model.dart';
import '../models/photos_result_model.dart';

part 'customer_market_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerMarketRemoteDataSource {
  factory CustomerMarketRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerMarketRemoteDataSource;

  @GET("customer/Market/GetNearByMarkets")
  @Headers({
    "Content-Type": "application/json",
    "Accept": "text/plain",
  })
  Future<NearByMarketsResultModel> nearbyMarkets(
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("maxDistance") int maxDistance,
    @Query("count") int count,
  );

  @GET("customer/Market/GetMarketDetail")
  @Headers({
    "Content-Type": "application/json",
    "Accept": "text/plain",
  })
  Future<MarketDetailResultModel> marketDetail(
    @Query("Id") String id,
  );

  @GET("customer/Market/GetPhoto")
  @Headers({
    "Content-Type": "application/json",
    "Accept": "text/plain",
  })
  Future<List<int>> photo(
    @Query("Id") String id,
  );

  @GET("customer/Market/GetPhotos")
  @Headers({
    "Content-Type": "application/json",
    "Accept": "text/plain",
  })
  Future<PhotosResultModel> photos(
    @Query("Id") String id,
  );
}

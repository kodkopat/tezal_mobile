import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../models/nearby_markets_result_model.dart';

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
}

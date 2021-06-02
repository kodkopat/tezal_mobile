import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/customer/search_result_model.dart';
import '../../models/customer/search_terms_result_model.dart';

part 'customer_search_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerSearchRemoteDataSource {
  factory CustomerSearchRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerSearchRemoteDataSource;

  static const _apiUrlPrefix = "Search";

  @GET("$_apiUrlPrefix/Search")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SearchResultModel> search(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Header("latitude") String? latitude,
    @Header("longitude") String? longitude,
    @Query("distanceAscending") bool? distanceAscending,
    @Query("scoreAscending") bool? scoreAscending,
    @Query("priceAscending") bool? priceAscending,
    @Query("Term") String term,
  );

  @GET("$_apiUrlPrefix/GetSearchTerms")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SearchTermsResultModel> getSearchTerms(
    @Header("lang") String lang,
    @Header("token") String? token,
  );

  @GET("$_apiUrlPrefix/ClearSearchTerms")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> clearSearchTerms(
    @Header("lang") String lang,
    @Header("token") String? token,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/clear_search_terms_result_model.dart';
import '../../models/search_result_model.dart';
import '../../models/search_terms_result_model.dart';

part 'customer_search_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerSearchRemoteDataSource {
  factory CustomerSearchRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerSearchRemoteDataSource;

  static const _apiUrlPrefix = "customer/Search";

  @GET("$_apiUrlPrefix/Search")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SearchResultModel> search(
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("Term") String term,
  );

  @GET("$_apiUrlPrefix/GetSearchTerms")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SearchTermsResultModel> getSearchTerms(
    @Header("token") String token,
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @GET("$_apiUrlPrefix/ClearSearchTerms")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<ClearSearchTermsResultModel> clearSearchTerms();
}

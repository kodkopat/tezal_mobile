import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/customer/base_api_result_model.dart';
import '../../models/customer/search_result_model.dart';
import '../../models/customer/search_terms_result_model.dart';

part 'customer_search_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerSearchRemoteDataSource {
  factory CustomerSearchRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerSearchRemoteDataSource;

  @GET("Search/Search")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SearchResultModel> search(
    @Header("token") String token,
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("Term") String term,
  );

  @GET("Search/GetSearchTerms")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SearchTermsResultModel> getSearchTerms(
    @Header("token") String token,
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @GET("Search/ClearSearchTerms")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> clearSearchTerms(
    @Header("token") String token,
    @Header("lang") String lang,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );
}

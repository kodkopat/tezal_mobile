import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';

part 'shared_application_remote_data_source.g.dart';

@RestApi(baseUrl: sharedBaseApiUrl)
abstract class SharedApplicationRemoteDataSource {
  factory SharedApplicationRemoteDataSource(Dio dio, {String? baseUrl}) =
      _SharedApplicationRemoteDataSource;

  static const _apiUrlPrefix = "Application";

  @GET("$_apiUrlPrefix/HasUpdate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> hasUpdate(
    @Header("lang") String? lang,
    @Query("Version") String version,
  );

  @GET("$_apiUrlPrefix/GetUpdate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> getUpdate(
    @Header("lang") String? lang,
    @Query("Version") String version,
  );

  @POST("$_apiUrlPrefix/Share")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> share(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Body() List<String> contactNumbers,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';
import '../../models/customer/base_api_result_model.dart';

part 'shared_application_remote_data_source.g.dart';

@RestApi(baseUrl: sharedBaseApiUrl)
abstract class SharedApplicationRemoteDataSource {
  factory SharedApplicationRemoteDataSource(Dio dio, {String? baseUrl}) =
      _SharedApplicationRemoteDataSource;

  static const _apiUrlPrefix = "Application";

  @GET("$_apiUrlPrefix/HasNewVersion")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> hasNewVersion(
    @Query("Version") String version,
  );

  @GET("$_apiUrlPrefix/GetUpdate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> getUpdate(
    @Query("Version") String version,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/photo_result_model.dart';
import '../../models/photos_result_model.dart';

part 'shared_application_remote_data_source.g.dart';

@RestApi(baseUrl: sharedBaseApiUrl)
abstract class SharedApplicationRemoteDataSource {
  factory SharedApplicationRemoteDataSource(Dio dio, {String? baseUrl}) =
      _SharedApplicationRemoteDataSource;

  static const _apiUrlPrefix = "Application";

  @GET("$_apiUrlPrefix/HasNewVersion")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> hasNewVersion(
    @Header("lang") String lang,
    @Query("Version") String version,
  );

  @GET("$_apiUrlPrefix/GetUpdate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> getUpdate(
    @Header("lang") String lang,
    @Query("Version") String version,
  );

  @POST("$_apiUrlPrefix/Share")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> share(
    @Header("lang") String lang,
    @Header("token") String token,
    @Body() List<String> contactNumbers,
  );

  @GET("$_apiUrlPrefix/GetProductPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getProductPhoto(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("productId") String productId,
    @Query("preview") bool preview,
  );

  @GET("$_apiUrlPrefix/GetProductPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotosResultModel> getProductPhotos(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("productId") String productId,
    @Query("preview") bool preview,
  );
}

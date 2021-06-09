import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';

part 'shared_product_remote_data_source.g.dart';

@RestApi(baseUrl: sharedBaseApiUrl)
abstract class SharedProductRemoteDataSource {
  factory SharedProductRemoteDataSource(Dio dio, {String? baseUrl}) =
      _SharedProductRemoteDataSource;

  static const _apiUrlPrefix = "Product";

  @GET("$_apiUrlPrefix/HasUpdate")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> hasUpdate(
    @Header("lang") String? lang,
    @Query("Version") String version,
  );

  @GET("$_apiUrlPrefix/GetProductPhotoList")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getProductPhotoList(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("Id") String productId,
  );

  @POST("$_apiUrlPrefix/GetProductPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getProductPhoto(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("productId") String productId,
    @Query("PhotoId") String photoId,
  );
}

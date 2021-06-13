import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';

part 'shared_remote_data_source.g.dart';

@RestApi(baseUrl: sharedBaseApiUrl)
abstract class SharedRemoteDataSource {
  factory SharedRemoteDataSource(Dio dio, {String? baseUrl}) =
      _SharedRemoteDataSource;

  static const _apiUrlPrefix = "Shared";

  @GET("$_apiUrlPrefix/GetProductPhoto")
  Future<dynamic> getProductPhoto(@Query("Id") String id);

  @GET("$_apiUrlPrefix/GetMarketPhoto")
  Future<dynamic> getMarketPhoto(@Query("Id") String id);

  @GET("$_apiUrlPrefix/GetMarketCategoryPhoto")
  Future<dynamic> getMarketCategoryPhoto(@Query("Id") String id);

  @GET("$_apiUrlPrefix/GetMainCategoryPhoto")
  Future<dynamic> getMainCategoryPhoto(@Query("Id") String id);

  @GET("$_apiUrlPrefix/GetSubCategoryPhoto")
  Future<dynamic> getSubCategoryPhoto(@Query("Id") String id);
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/customer/main_category_result_model.dart';
import '../../models/customer/photo_result_model.dart';
import '../../models/customer/sub_category_result_model.dart';

part 'customer_category_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerCategoryRemoteDataSource {
  factory CustomerCategoryRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerCategoryRemoteDataSource;

  static const _apiUrlPrefix = "Category";

  @GET("$_apiUrlPrefix/GetMainCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoryResultModel> getMainCategories(
    @Header("lang") String lang,
    @Query("MarketId") String marketId,
  );

  @GET("$_apiUrlPrefix/GetSubCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryResultModel> getSubCategories(
    @Header("lang") String lang,
    @Query("MarketId") String marketId,
    @Query("MainCategoryId") String mainCategoryId,
  );

  @GET("$_apiUrlPrefix/GetMainCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getMainCategoryPhoto(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetSubCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getSubCategoryPhoto(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/main_category_result_model.dart';
import '../../models/photo_result_model.dart';
import '../../models/sub_category_result_model.dart';

part 'customer_category_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerCategoryRemoteDataSource {
  factory CustomerCategoryRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerCategoryRemoteDataSource;

  @GET("GetMainCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoryResultModel> getMainCategories(
    @Query("MarketId") String marketId,
  );

  @GET("GetSubCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryResultModel> getSubCategories(
    @Query("MarketId") String marketId,
    @Query("MainCategoryId") String mainCategoryId,
  );

  @GET("GetMainCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getMainCategoryPhoto(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("GetSubCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getSubCategoryPhoto(
    @Header("token") String token,
    @Query("Id") String id,
  );
}

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

  @GET("Category/GetMainCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoryResultModel> getMainCategories(
    @Query("MarketId") String marketId,
  );

  @GET("Category/GetSubCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryResultModel> getSubCategories(
    @Query("MarketId") String marketId,
    @Query("MainCategoryId") String mainCategoryId,
  );

  @GET("Category/GetMainCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getMainCategoryPhoto(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("Category/GetSubCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getSubCategoryPhoto(
    @Header("token") String token,
    @Query("Id") String id,
  );
}

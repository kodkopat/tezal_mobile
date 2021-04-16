import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/main_category_result_model.dart';
import '../../models/photo_result_model.dart';
import '../../models/sub_category_result_model.dart';

part 'customer_category_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerCategoryRemoteDataSource {
  factory CustomerCategoryRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerCategoryRemoteDataSource;

  static const _apiUrlPrefix = "customer/Category";

  @GET("$_apiUrlPrefix/GetMainCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoryResultModel> getMainCategories();

  @GET("$_apiUrlPrefix/GetSubCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryResultModel> getSubCategories(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetMainCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getMainCategoryPhoto(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetSubCategoryPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getSubCategoryPhoto(
    @Header("token") String token,
    @Query("Id") String id,
  );
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/photo_result_model.dart';

part 'customer_product_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerProductRemoteDataSource {
  factory CustomerProductRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerProductRemoteDataSource;

  static const _apiUrlPrefix = "customer/Product";

  @POST("$_apiUrlPrefix/List")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> list(
    @Query("PageSize") int pageSize,
    @Query("Page") int page,
    @Query("OrderBy") String orderBy,
  );

  @GET("$_apiUrlPrefix/GetDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getDetail(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getPhoto(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetMarketProductPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getMarketProductPhoto(
    @Query("Id") String id,
  );

  @POST("$_apiUrlPrefix/Save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> save(
    @Field() String id,
    @Field() String categoryId,
    @Field() String name,
    @Field() String description,
    @Field() double discountedPrice,
    @Field() double originalPrice,
    @Field() bool onSale,
  );

  @GET("$_apiUrlPrefix/Like")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> like(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/Unlike")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> unlike(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetLikedProducts")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getLikedProducts();
}

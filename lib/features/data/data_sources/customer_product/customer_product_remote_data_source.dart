import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/all_products_result_model.dart';
import '../../models/base_api_result_model.dart';
import '../../models/comments_result_model.dart';
import '../../models/liked_products_result_model.dart';
import '../../models/photos_result_model.dart';
import '../../models/product_detail_result_model.dart';

part 'customer_product_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerProductRemoteDataSource {
  factory CustomerProductRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerProductRemoteDataSource;

  static const _apiUrlPrefix = "customer/Product";

  @POST("$_apiUrlPrefix/GetAll")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AllProductsResultModel> getAll(
    @Query("MarketId") String marketId,
    @Query("CategoryId") String categoryId,
  );

  @GET("$_apiUrlPrefix/GetDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<ProductDetailResultModel> getDetail(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotosResultModel> getPhoto(
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/Like")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> like(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/Unlike")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> unlike(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetLikedProducts")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<LikedProductsResultModel> getLikedProducts(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CommentsResultModel> getComments(
    @Query("productId") String productId,
    @Query("Page") int page,
  );

  @GET("$_apiUrlPrefix/AddComment")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addComment();
}

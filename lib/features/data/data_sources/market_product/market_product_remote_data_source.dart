import 'package:dio/dio.dart' hide Headers;

import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';

part 'market_product_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketProductRemoteDataSource {
  factory MarketProductRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketProductRemoteDataSource;

  static const _apiUrlPrefix = "MarketProduct";

  @GET("$_apiUrlPrefix/GetMainCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getMainCategories(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @GET("$_apiUrlPrefix/GetSubCategoriesOfCategory")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getSubCategoriesOfCategory(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("mainCategoryId") String mainCategoryId,
  );

  @GET("$_apiUrlPrefix/GetProductsOfSubCategory")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getProductsOfSubCategory(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("subCategoryId") String subCategoryId,
  );

  @GET("$_apiUrlPrefix/GetMarketProduct")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getMarketProduct(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
  );

  @POST("$_apiUrlPrefix/AddToProductMarket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addToProductMarket(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Field() String productId,
    @Field() double amount,
    @Field() double discountRate,
    @Field() double discountedPrice,
    @Field() double originalPrice,
    @Field() bool onSale,
    @Field() String description,
  );

  @DELETE("$_apiUrlPrefix/RemoveMarketProduct")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> removeMarketProduct(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Query("marketProductId") String marketProductId,
  );

  @POST("$_apiUrlPrefix/ChangeProductMarketAmount")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> changeProductMarketAmount(
    @Header("token") String token,
    @Header("latitude") String latitude,
    @Header("longitude") String longitude,
    @Field() String unknown,
  );
}
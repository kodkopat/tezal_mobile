import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/market/main_categories_result_model.dart';
import '../../models/market/market_products_result_model.dart';
import '../../models/market/sub_categories_result_model.dart';
import '../../models/market/sub_category_products_result_model.dart';

part 'market_product_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketProductRemoteDataSource {
  factory MarketProductRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketProductRemoteDataSource;

  static const _apiUrlPrefix = "MarketProduct";

  @GET("$_apiUrlPrefix/GetMainCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoriesResultModel> getMainCategories(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetCategoriesOfCategory")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoriesResultModel> getCategoriesOfCategory(
    @Header("token") String token,
    @Query("mainCategoryId") String mainCategoryId,
  );

  @GET("$_apiUrlPrefix/GetProducts")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryProductsResultModel> getProducts(
    @Header("token") String token,
    @Query("mainCategoryId") String mainCategoryId,
    @Query("subCategoryId") String subCategoryId,
  );

  @GET("$_apiUrlPrefix/GetMarketProduct")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketProductsResultModel> getMarketProduct(
    @Header("token") String token,
    @Query("mainCategoryId") String mainCategoryId,
    @Query("subCategoryId") String subCategoryId,
  );

  @POST("$_apiUrlPrefix/AddToProductMarket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> addToProductMarket(
    @Header("token") String token,
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
    @Query("marketProductId") String marketProductId,
  );

  @POST("$_apiUrlPrefix/ChangeProductMarketAmount")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> changeProductMarketAmount(
    @Header("token") String token,
    @Field() String unknown,
  );

  @GET("$_apiUrlPrefix/SetOnSale")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> setOnSale(
    @Header("token") String token,
    @Query("marketProductId") String marketProductId,
    @Query("onSale") bool onSale,
  );

  @GET("$_apiUrlPrefix/GetProductComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getProductComments(
    @Header("token") String token,
    @Query("marketProductId") String marketProductId,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/ReplyProductComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> replyProductComments(
    @Header("token") String token,
    @Field() String commentId,
    @Field() String reply,
  );
}

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

  @GET("$_apiUrlPrefix/GetSubCategoriesOfCategory")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoriesResultModel> getSubCategoriesOfCategory(
    @Header("token") String token,
    @Query("mainCategoryId") String mainCategoryId,
  );

  @GET("$_apiUrlPrefix/GetProductsOfSubCategory")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoryProductsResultModel> getProductsOfSubCategory(
    @Header("token") String token,
    @Query("subCategoryId") String subCategoryId,
  );

  @GET("$_apiUrlPrefix/GetMarketProduct")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketProductsResultModel> getMarketProduct(
    @Header("token") String token,
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
}

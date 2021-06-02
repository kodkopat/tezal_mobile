import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/market/main_categories_result_model.dart';
import '../../models/market/market_products_result_model.dart';
import '../../models/market/product_comments_result_model.dart';
import '../../models/market/products_result_model.dart';
import '../../models/market/sub_categories_result_model.dart';

part 'market_product_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketProductRemoteDataSource {
  factory MarketProductRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketProductRemoteDataSource;

  static const _apiUrlPrefix = "MarketProduct";

  @GET("$_apiUrlPrefix/GetMainCategories")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MainCategoriesResultModel> getMainCategories(
    @Header("lang") String lang,
    @Header("token") String? token,
  );

  @GET("$_apiUrlPrefix/GetCategoriesOfCategory")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<SubCategoriesResultModel> getCategoriesOfCategory(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Query("mainCategoryId") String mainCategoryId,
  );

  @GET("$_apiUrlPrefix/GetNotListedProducts")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<ProductsResultModel> getNotListedProducts(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Query("mainCategoryId") String? mainCategoryId,
    @Query("subCategoryId") String? subCategoryId,
    @Query("term") String? term,
  );

  @GET("$_apiUrlPrefix/GetProducts")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<ProductsResultModel> getProducts(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Query("mainCategoryId") String mainCategoryId,
    @Query("subCategoryId") String subCategoryId,
  );

  @GET("$_apiUrlPrefix/GetMarketProducts")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<MarketProductsResultModel> getMarketProducts(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Query("mainCategoryId") String mainCategoryId,
    @Query("subCategoryId") String subCategoryId,
  );

  @POST("$_apiUrlPrefix/AddToProductMarket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> addToProductMarket(
    @Header("lang") String lang,
    @Header("token") String? token,
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
  Future<BaseApiResultModel> removeMarketProduct(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Query("marketProductId") String marketProductId,
  );

  @POST("$_apiUrlPrefix/ChangeProductMarketAmount")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> changeProductMarketAmount(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Field() String unknown,
  );

  @GET("$_apiUrlPrefix/SetOnSale")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> setOnSale(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Query("marketProductId") String marketProductId,
    @Query("onSale") bool onSale,
  );

  @GET("$_apiUrlPrefix/GetProductComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<ProductCommentsResultModel> getProductComments(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Query("marketProductId") String marketProductId,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/ReplyProductComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> replyProductComments(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Field() String commentId,
    @Field() String reply,
  );

  @POST("$_apiUrlPrefix/AddProductDraft")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> addProductDraft(
    @Header("lang") String lang,
    @Header("token") String? token,
    @Field() String name,
    @Field() String description,
    @Field() double discountedPrice,
    @Field() double originalPrice,
    @Field() String mainCategoryId,
  );
}

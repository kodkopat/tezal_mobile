import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/basket_count_result_model.dart';
import '../../models/basket_result_model.dart';
import '../../models/payment_info_result_model.dart';

part 'customer_basket_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerBasketRemoteDataSource {
  factory CustomerBasketRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerBasketRemoteDataSource;

  static const _apiUrlPrefix = "customer/Basket";

  @GET("$_apiUrlPrefix/EmptyBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> emptyBasket(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BasketResultModel> getBasket(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetPaymentInfo")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PaymentInfoResultModel> getPaymentInfo(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/SelectAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> selectAddress(
    @Header("token") String token,
    @Query("Id") String addressId,
  );

  @POST("$_apiUrlPrefix/AddProductToBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> addProductToBasket(
    @Header("token") String token,
    @Field() String id,
    @Field() int amount,
  );

  @POST("$_apiUrlPrefix/RemoveProductFromBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> removeProductFromBasket(
    @Header("token") String token,
    @Field() String id,
    @Field() int amount,
  );

  @GET("$_apiUrlPrefix/getBasketCount")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BasketCountResultModel> getBasketCount(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/UpdateBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> updateBasket(
    @Header("token") String token,
    @Query("Note") String note,
  );
}
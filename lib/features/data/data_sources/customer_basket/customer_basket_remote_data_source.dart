import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/basket_result_model.dart';
import '../../models/payment_info_result_model.dart';

part 'customer_basket_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerBasketRemoteDataSource {
  factory CustomerBasketRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerBasketRemoteDataSource;

  @GET("Basket/EmptyBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> emptyBasket(
    @Header("token") String token,
  );

  @GET("Basket/GetBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BasketResultModel> getBasket(
    @Header("token") String token,
  );

  @GET("Basket/GetPaymentInfo")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PaymentInfoResultModel> getPaymentInfo(
    @Header("token") String token,
  );

  @GET("Basket/SelectAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> selectAddress(
    @Header("token") String token,
    @Query("Id") String addressId,
  );

  @POST("Basket/AddProductToBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> addProductToBasket(
    @Header("token") String token,
    @Field() String id,
    @Field() int amount,
  );

  @POST("Basket/RemoveProductFromBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> removeProductFromBasket(
    @Header("token") String token,
    @Field() String id,
    @Field() int amount,
  );

  @GET("Basket/getBasketCount")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> getBasketCount(
    @Header("token") String token,
  );

  @GET("Basket/UpdateBasket")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> updateBasket(
    @Header("token") String token,
    @Query("Note") String note,
  );
}

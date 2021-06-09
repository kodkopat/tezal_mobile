import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/market/order_comments_result_model.dart';
import '../../models/market/order_photos_result_model.dart';
import '../../models/market/orders_result_model.dart';

part 'market_order_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketOrderRemoteDataSource {
  factory MarketOrderRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketOrderRemoteDataSource;

  static const _apiUrlPrefix = "Order";

  @GET("$_apiUrlPrefix/GetOrders")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrdersResultModel> getOrders(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("skip") int skip,
    @Query("take") int take,
    @Query("status") String status,
    @Query("distanceAscending") bool? distanceAscending,
    @Query("dateAscescending") bool? dateAscescending,
    @Query("priceAscending") bool? priceAscending,
  );

  @GET("$_apiUrlPrefix/ApproveOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> approveOrder(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/CancelOrderApprove")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> cancelOrderApprove(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetOrderPhotos")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrderPhotosResultModel> getOrderPhotos(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("orderId") String orderId,
  );

  @GET("$_apiUrlPrefix/GetOrderSummary")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getOrderSummary(
    @Header("lang") String? lang,
    @Header("token") String? token,
  );

  @GET("$_apiUrlPrefix/GetPostOrderSummary")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getPostOrderSummary(
    @Header("lang") String? lang,
    @Header("token") String? token,
  );

  @GET("$_apiUrlPrefix/GetOrderDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<dynamic> getOrderDetail(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/RejectOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> rejectOrder(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/PrepareOrder")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> prepareOrder(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/ReturnedOrderApprove")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> returnedOrderApprove(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/GetOrderComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<OrderCommentsResultModel> getOrderComments(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Query("orderId") String orderId,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/ReplyOrderComments")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> replyOrderComments(
    @Header("lang") String? lang,
    @Header("token") String? token,
    @Field() String commentId,
    @Field() String reply,
  );
}

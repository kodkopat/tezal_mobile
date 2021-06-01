import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/wallet_balance_result_model.dart';
import '../../models/wallet_detail_result_model.dart';
import '../../models/withdrawal_requests_result_model.dart';

part 'delivery_wallet_remote_data_source.g.dart';

@RestApi(baseUrl: deliveryBaseApiUrl)
abstract class DeliveryWalletRemoteDataSource {
  factory DeliveryWalletRemoteDataSource(Dio dio, {String? baseUrl}) =
      _DeliveryWalletRemoteDataSource;

  static const _apiUrlPrefix = "Wallet";

  @GET("$_apiUrlPrefix/GetBalance")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WalletBalanceResultModel> getBalance(
    @Header("lang") String lang,
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetWalletDetails")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WalletDetailResultModel> getWalletDetails(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @GET("$_apiUrlPrefix/GetWithdrawalRequests")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WithdrawalRequestsResultModel> getWithdrawalRequests(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/WithdrawalRequest")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> withdrawalRequest(
    @Header("lang") String lang,
    @Header("token") String token,
    @Field() double amount,
    @Field() String description,
  );
}

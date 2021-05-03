import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/customer/base_api_result_model.dart';
import '../../models/market/wallet_balance_result_model.dart';
import '../../models/market/wallet_detail_result_model.dart';
import '../../models/market/withdrawal_requests_result_model.dart';

part 'market_wallet_remote_data_source.g.dart';

@RestApi(baseUrl: marketBaseApiUrl)
abstract class MarketWalletRemoteDataSource {
  factory MarketWalletRemoteDataSource(Dio dio, {String? baseUrl}) =
      _MarketWalletRemoteDataSource;

  static const _apiUrlPrefix = "Wallet";

  @GET("$_apiUrlPrefix/GetBalance")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WalletBalanceResultModel> getBalance(
    @Header("token") String token,
  );

  @GET("$_apiUrlPrefix/GetWalletDetails")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WalletDetailResultModel> getWalletDetails(
    @Header("token") String token,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @GET("$_apiUrlPrefix/GetWithdrawalRequests")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WithdrawalRequestsResultModel> getWithdrawalRequests(
    @Header("token") String token,
    @Query("skip") int skip,
    @Query("take") int take,
  );

  @POST("$_apiUrlPrefix/WithdrawalRequest")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> withdrawalRequest(
    @Header("token") String token,
    @Field() double amount,
    @Field() String description,
  );
}

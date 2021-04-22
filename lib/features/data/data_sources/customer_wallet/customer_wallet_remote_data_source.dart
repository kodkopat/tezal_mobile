import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/wallet_detail_result_model.dart';
import '../../models/wallet_info_result_model.dart';
import '../../models/wallet_load_balance_result_model.dart';

part 'customer_wallet_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerWalletRemoteDataSource {
  factory CustomerWalletRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerWalletRemoteDataSource;

  @GET("GetWalletInfo")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WalletInfoResultModel> getWalletInfo(
    @Header("token") String token,
  );

  @GET("GetWalletDetail")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WalletDetailResultModel> getWalletDetail(
    @Header("token") String token,
    @Query("page") int page,
  );

  @GET("LoadBalance")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WalletLoadBalanceResultModel> loadBalance(
    @Header("token") String token,
    @Query("amount") double amount,
  );

  @GET("LoadBalanceConfirmation")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<WalletLoadBalanceResultModel> loadBalanceConfirmation(
    @Header("token") String token,
    @Query("Id") String id,
  );
}

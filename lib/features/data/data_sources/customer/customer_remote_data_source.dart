import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/customer_profile_result_model.dart';

part 'customer_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class CustomerRemoteDataSource {
  factory CustomerRemoteDataSource(Dio dio, {String baseUrl}) =
      _CustomerRemoteDataSource;
  static const _apiUrlPrefix = "customer/Customer";

  @GET("$_apiUrlPrefix/GetCustomerProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CustomerProfileResultModel> getCustomerProfile(
    @Header("token") String token,
  );

  @POST("$_apiUrlPrefix/ChangeCustomerProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> changeCustomerProfile(
    @Header("token") String token,
    @Field() String name,
    @Field() String email,
  );
}
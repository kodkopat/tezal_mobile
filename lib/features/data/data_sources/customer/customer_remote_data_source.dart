import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/customer/customer_profile_result_model.dart';
import '../../models/customer/photo_result_model.dart';

part 'customer_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerRemoteDataSource {
  factory CustomerRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerRemoteDataSource;

  static const _apiUrlPrefix = "Customer";

  @GET("$_apiUrlPrefix/GetCustomerProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CustomerProfileResultModel> getCustomerProfile(
    @Header("lang") String lang,
    @Header("token") String token,
  );

  @POST("$_apiUrlPrefix/ChangeCustomerProfile")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> changeCustomerProfile(
    @Header("lang") String lang,
    @Header("token") String token,
    @Field() String name,
    @Field() String email,
    @Field() String photo,
  );

  @GET("$_apiUrlPrefix/getphoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getPhoto(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );
}

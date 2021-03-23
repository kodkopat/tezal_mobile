import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';
import '../../models/check_sms_result_model.dart';
import '../../models/check_token_result_model.dart';
import '../../models/login_result_model.dart';
import '../../models/register_result_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSource;

  static const _apiUrlPrefix = "User";

  @POST("$_apiUrlPrefix/Login")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<LoginResultModel> login(
    @Field() String username,
    @Field() String password,
  );

  @POST("$_apiUrlPrefix/CheckToken")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CheckTokenResultModel> checkToken(
    @Field() String token,
  );

  @POST("$_apiUrlPrefix/Register")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<RegisterResultModel> register(
    @Field("Name") String name,
    @Field("Phone") String phone,
    @Field("Password") String pass,
  );

  @POST("$_apiUrlPrefix/ConfirmRegistration")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CheckSmsResultModel> confirmRegistration(
    @Field() String id,
    @Field() String sms,
  );
}

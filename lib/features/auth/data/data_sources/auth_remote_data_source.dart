import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';
import '../models/check_sms_result_model.dart';
import '../models/check_token_result_model.dart';
import '../models/login_result_model.dart';
import '../models/register_result_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSource;

  @Headers({
    "Content-Type": "application/json",
    "Accept": "text/plain",
  })
  @POST("User/Register")
  Future<RegisterResultModel> register(
    @Field() String name,
    @Field() String phone,
    @Field() String pass,
  );

  @Headers({
    "Content-Type": "application/json",
    "Accept": "text/plain",
  })
  @POST("User/CheckSms")
  Future<CheckSmsResultModel> checkSms(
    @Field() String id,
    @Field() String sms,
  );

  @Headers({
    "Content-Type": "application/json",
    "Accept": "text/plain",
  })
  @POST("User/Login")
  Future<LoginResultModel> login(
    @Field() String username,
    @Field() String password,
  );

  @Headers({
    "Content-Type": "application/json",
    "Accept": "text/plain",
  })
  @POST("User/CheckToken")
  Future<CheckTokenResultModel> checkToken(
    @Field() String token,
  );
}

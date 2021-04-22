import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';
import '../../models/agreement_result_model.dart';
import '../../models/base_api_result_model.dart';
import '../../models/check_sms_result_model.dart';
import '../../models/check_token_result_model.dart';
import '../../models/login_result_model.dart';
import '../../models/register_result_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: sharedBaseApiUrl)
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String? baseUrl}) =
      _AuthRemoteDataSource;

  @POST("Login")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<LoginResultModel> login(
    @Field() String username,
    @Field() String password,
  );

  @POST("CheckToken")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CheckTokenResultModel> checkToken(
    @Field() String token,
  );

  @POST("Register")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<RegisterResultModel> register(
    @Field("Name") String name,
    @Field("Phone") String phone,
    @Field("Password") String pass,
  );

  @POST("ConfirmRegistration")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CheckSmsResultModel> confirmRegistration(
    @Field() String id,
    @Field() String sms,
  );

  @GET("ResetPasswordRequest")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> resetPasswordRequest(
    @Query("Phone") String phone,
  );

  @GET("ResetPassword")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> resetPassword(
    @Query("Phone") String phone,
    @Query("sms") String sms,
    @Query("Password") String password,
    @Query("PasswordRepeat") String passwordRepeat,
  );

  @GET("getPrivacyText")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AgreementResultModel> getPrivacyText();

  @GET("getRulesText")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AgreementResultModel> getRulesText();
}

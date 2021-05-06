import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/customer/agreement_result_model.dart';
import '../../models/customer/check_sms_result_model.dart';
import '../../models/customer/check_token_result_model.dart';
import '../../models/customer/login_result_model.dart';
import '../../models/customer/register_result_model.dart';
import '../../models/photo_result_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi(baseUrl: sharedBaseApiUrl)
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String? baseUrl}) =
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

  @GET("$_apiUrlPrefix/GetPhoto")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<PhotoResultModel> getPhoto(
    @Query("Token") String token,
  );

  @GET("$_apiUrlPrefix/ResetPasswordRequest")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> resetPasswordRequest(
    @Query("Phone") String phone,
  );

  @GET("$_apiUrlPrefix/ResetPassword")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> resetPassword(
    @Query("Phone") String phone,
    @Query("sms") String sms,
    @Query("Password") String password,
    @Query("PasswordRepeat") String passwordRepeat,
  );

  @GET("$_apiUrlPrefix/getPrivacyText")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AgreementResultModel> getPrivacyText();

  @GET("$_apiUrlPrefix/getRulesText")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AgreementResultModel> getRulesText();
}

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/base_api_result_model.dart';
import '../../models/customer/address_result_model.dart';
import '../../models/customer/addresses_result_model.dart';
import '../../models/customer/cities_result_model.dart';
import '../../models/customer/provinces_result_model.dart';

part 'customer_address_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerAddressRemoteDataSource {
  factory CustomerAddressRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerAddressRemoteDataSource;

  static const _apiUrlPrefix = "Address";

  @GET("$_apiUrlPrefix/GetProvince")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<ProvincesResultModel> getProvince(
    @Header("lang") String lang,
  );

  @GET("$_apiUrlPrefix/GetCity")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CitiesResultModel> getCity(
    @Header("lang") String lang,
    @Query("provinceId") String provinceId,
  );

  @POST("$_apiUrlPrefix/save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> save(
    @Header("lang") String lang,
    @Header("token") String token,
    @Field() String address,
    @Field() String description,
    @Field() bool isDefault,
    @Field() String cityId,
    @Field() String name,
    @Field() String latitude,
    @Field() String longitude,
  );

  @POST("$_apiUrlPrefix/save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> edit(
    @Header("lang") String lang,
    @Header("token") String token,
    @Field() String id,
    @Field() String address,
    @Field() String description,
    @Field() bool isDefault,
    @Field() String cityId,
    @Field() String name,
    @Field() String latitude,
    @Field() String longitude,
  );

  @GET("$_apiUrlPrefix/SetDefaultAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> setdefaultAddress(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/RemoveAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> removeAddress(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/getAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AddressResultModel> getAddress(
    @Header("lang") String lang,
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/getAddressess")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AddressesResultModel> getAddresses(
    @Header("lang") String lang,
    @Header("token") String token,
  );
}

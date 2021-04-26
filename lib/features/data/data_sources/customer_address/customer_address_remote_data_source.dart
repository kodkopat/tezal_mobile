import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/customer/address_result_model.dart';
import '../../models/customer/addresses_result_model.dart';
import '../../models/customer/base_api_result_model.dart';
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
  Future<ProvincesResultModel> getProvince();

  @GET("$_apiUrlPrefix/GetCity")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CitiesResultModel> getCity(
    @Query("provinceId") String provinceId,
  );

  @POST("$_apiUrlPrefix/save")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> save(
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
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/RemoveAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> removeAddress(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/getAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AddressResultModel> getAddress(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("$_apiUrlPrefix/getAddressess")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AddressesResultModel> getAddresses(
    @Header("token") String token,
  );
}

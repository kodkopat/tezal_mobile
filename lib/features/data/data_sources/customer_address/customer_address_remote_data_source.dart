import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/consts/consts.dart';
import '../../models/address_result_model.dart';
import '../../models/addresses_result_model.dart';
import '../../models/base_api_result_model.dart';
import '../../models/cities_result_model.dart';
import '../../models/provinces_result_model.dart';

part 'customer_address_remote_data_source.g.dart';

@RestApi(baseUrl: customerBaseApiUrl)
abstract class CustomerAddressRemoteDataSource {
  factory CustomerAddressRemoteDataSource(Dio dio, {String? baseUrl}) =
      _CustomerAddressRemoteDataSource;

  @GET("Address/GetProvince")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<ProvincesResultModel> getProvince();

  @GET("Address/GetCity")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<CitiesResultModel> getCity(
    @Query("provinceId") String provinceId,
  );

  @POST("Address/save")
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

  @POST("Address/save")
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

  @GET("Address/SetDefaultAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> setdefaultAddress(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("Address/RemoveAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<BaseApiResultModel> removeAddress(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("Address/getAddress")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AddressResultModel> getAddress(
    @Header("token") String token,
    @Query("Id") String id,
  );

  @GET("Address/getAddressess")
  @Headers({"Content-Type": "application/json", "Accept": "text/plain"})
  Future<AddressesResultModel> getAddresses(
    @Header("token") String token,
  );
}

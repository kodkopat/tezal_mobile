// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_address_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerAddressRemoteDataSource
    implements CustomerAddressRemoteDataSource {
  _CustomerAddressRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/customer/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ProvincesResultModel> getProvince(lang) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProvincesResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Address/GetProvince',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProvincesResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CitiesResultModel> getCity(lang, provinceId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'provinceId': provinceId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CitiesResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Address/GetCity',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CitiesResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> save(lang, token, address, description, isDefault,
      cityId, name, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'address': address,
      'description': description,
      'isDefault': isDefault,
      'cityId': cityId,
      'name': name,
      'latitude': latitude,
      'longitude': longitude
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Address/save',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> edit(lang, token, id, address, description,
      isDefault, cityId, name, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'id': id,
      'address': address,
      'description': description,
      'isDefault': isDefault,
      'cityId': cityId,
      'name': name,
      'latitude': latitude,
      'longitude': longitude
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Address/save',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> setdefaultAddress(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Address/SetDefaultAddress',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> removeAddress(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Address/RemoveAddress',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddressResultModel> getAddress(lang, token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddressResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Address/getAddress',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddressResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddressesResultModel> getAddresses(lang, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddressesResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Address/getAddressess',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddressesResultModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

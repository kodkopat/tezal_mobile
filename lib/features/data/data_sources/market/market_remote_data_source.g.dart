// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MarketRemoteDataSource implements MarketRemoteDataSource {
  _MarketRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/market/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<dynamic> save(token, latitude, longitude, id, name, phone, telephone,
      email, address) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'id': id,
      'name': name,
      'phone': phone,
      'telephone': telephone,
      'email': email,
      'address': address
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'POST',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/Save',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getCustomerProfile(token, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/GetCustomerProfile',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> changeMarketProfile(token, latitude, longitude, id, name,
      phone, telephone, email, address) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'id': id,
      'name': name,
      'phone': phone,
      'telephone': telephone,
      'email': email,
      'address': address
    };
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'POST',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/ChangeMarketProfile',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> openCloseMarket(token, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'POST',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/OpenCloseMarket',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> updateMarketDefaultHours(token, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'POST',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/UpdateMarketDefaultHours',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getMarketDefaultHours(token, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/GetMarketDefaultHours',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getMarketPhotos(
      token, latitude, longitude, photoId, take, skip) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'photoId': photoId,
      r'take': take,
      r'skip': skip
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'POST',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/GetMarketPhotos',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> addMarketPhoto(token, latitude, longitude, photo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'photo': photo};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'POST',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/AddMarketPhoto',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> removeMarketPhoto(token, latitude, longitude, photoId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'photoId': photoId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'DELETE',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Market/RemoveMarketPhoto',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
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

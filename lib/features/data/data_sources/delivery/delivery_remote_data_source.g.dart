// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DeliveryRemoteDataSource implements DeliveryRemoteDataSource {
  _DeliveryRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/delivery/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<dynamic> setAvailablity(lang, token, available) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'available': available};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'lang': lang,
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Delivery/SetAvailablity',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> setLocation(lang, token, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'lang': lang,
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Delivery/SetLocation',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> list(
      lang, token, latitude, longitude, pageSize, page, orderBy) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'PageSize': pageSize,
      r'Page': page,
      r'OrderBy': orderBy
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'lang': lang,
              r'token': token,
              r'latitude': latitude,
              r'longitude': longitude
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'DeliveryCenter/List',
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

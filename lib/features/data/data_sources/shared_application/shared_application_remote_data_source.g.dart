// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_application_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SharedApplicationRemoteDataSource
    implements SharedApplicationRemoteDataSource {
  _SharedApplicationRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/shared/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseApiResultModel> hasNewVersion(version) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Version': version};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain'
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Application/HasNewVersion',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> getUpdate(version) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Version': version};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain'
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Application/GetUpdate',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> share(token, contactNumbers) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'contactNumbers': contactNumbers};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Application/Share',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
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

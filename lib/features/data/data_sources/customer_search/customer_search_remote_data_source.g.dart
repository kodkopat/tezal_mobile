// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_search_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerSearchRemoteDataSource
    implements CustomerSearchRemoteDataSource {
  _CustomerSearchRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/customer/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SearchResultModel> search(
      lang, token, latitude, longitude, term) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Term': term};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchResultModel>(Options(
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
            .compose(_dio.options, 'Search/Search',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchTermsResultModel> getSearchTerms(
      lang, token, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchTermsResultModel>(Options(
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
            .compose(_dio.options, 'Search/GetSearchTerms',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchTermsResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> clearSearchTerms(
      lang, token, latitude, longitude) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
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
            .compose(_dio.options, 'Search/ClearSearchTerms',
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

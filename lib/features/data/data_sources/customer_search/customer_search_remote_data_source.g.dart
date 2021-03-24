// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_search_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerSearchRemoteDataSource
    implements CustomerSearchRemoteDataSource {
  _CustomerSearchRemoteDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://178.157.14.77/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<SearchResultModel> search(lang, latitude, longitude, term) async {
    ArgumentError.checkNotNull(lang, 'lang');
    ArgumentError.checkNotNull(latitude, 'latitude');
    ArgumentError.checkNotNull(longitude, 'longitude');
    ArgumentError.checkNotNull(term, 'term');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Term': term};
    final _data = <String, dynamic>{};
    final _result =
        await _dio.request<Map<String, dynamic>>('customer/Search/Search',
            queryParameters: queryParameters,
            options: RequestOptions(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'latitude': latitude,
                  r'longitude': longitude
                },
                extra: _extra,
                contentType: 'application/json',
                baseUrl: baseUrl),
            data: _data);
    final value = SearchResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchTermsResultModel> getSearchTerms() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Search/GetSearchTerms',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain'
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = SearchTermsResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ClearSearchTermsResultModel> clearSearchTerms() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Search/ClearSearchTerms',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain'
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = ClearSearchTermsResultModel.fromJson(_result.data);
    return value;
  }
}

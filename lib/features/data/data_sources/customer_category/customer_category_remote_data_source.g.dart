// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_category_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerCategoryRemoteDataSource
    implements CustomerCategoryRemoteDataSource {
  _CustomerCategoryRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/customer/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<MainCategoryResultModel> getMainCategories(marketId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'MarketId': marketId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MainCategoryResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain'
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Category/GetMainCategories',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MainCategoryResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SubCategoryResultModel> getSubCategories(
      marketId, mainCategoryId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'MarketId': marketId,
      r'MainCategoryId': mainCategoryId
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SubCategoryResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain'
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Category/GetSubCategories',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SubCategoryResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PhotoResultModel> getMainCategoryPhoto(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PhotoResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Category/GetMainCategoryPhoto',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PhotoResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PhotoResultModel> getSubCategoryPhoto(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PhotoResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Category/GetSubCategoryPhoto',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PhotoResultModel.fromJson(_result.data!);
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

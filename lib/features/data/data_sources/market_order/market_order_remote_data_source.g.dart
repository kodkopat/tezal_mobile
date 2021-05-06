// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_order_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MarketOrderRemoteDataSource implements MarketOrderRemoteDataSource {
  _MarketOrderRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/market/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OrdersResultModel> getOrders(token, skip, take, status,
      distanceAscending, dateAscescending, priceAscending) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'skip': skip,
      r'take': take,
      r'status': status,
      r'distanceAscending': distanceAscending,
      r'dateAscescending': dateAscescending,
      r'priceAscending': priceAscending
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrdersResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/GetOrders',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrdersResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> approveOrder(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/ApproveOrder',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> cancelOrderApprove(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/CancelOrderApprove',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderPhorosResultModel> getOrderPhotos(token, orderId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderId': orderId};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderPhorosResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/GetOrderPhotos',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderPhorosResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getOrderSummary(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/GetOrderSummary',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getPostOrderSummary(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/GetPostOrderSummary',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getOrderDetail(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/GetOrderDetail',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<BaseApiResultModel> rejectOrder(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Order/RejectOrder',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> prepareOrder(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/PrepareOrder',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> returnedOrderApprove(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/ReturnedOrderApprove',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> getOrderComments(token, orderId, skip, take) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'orderId': orderId,
      r'skip': skip,
      r'take': take
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/GetOrderComments',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<dynamic> replyOrderComments(token, commentId, reply) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'commentId': commentId, 'reply': reply};
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
            method: 'POST',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json')
        .compose(_dio.options, 'Order/ReplyOrderComments',
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

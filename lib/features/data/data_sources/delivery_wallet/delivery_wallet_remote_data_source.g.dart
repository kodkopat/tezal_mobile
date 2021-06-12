// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_wallet_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DeliveryWalletRemoteDataSource
    implements DeliveryWalletRemoteDataSource {
  _DeliveryWalletRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/delivery/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<WalletBalanceResultModel> getBalance(lang, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WalletBalanceResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Wallet/GetBalance',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WalletBalanceResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WalletDetailResultModel> getWalletDetails(
      lang, token, skip, take) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'skip': skip, r'take': take};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WalletDetailResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Wallet/GetWalletDetails',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WalletDetailResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WithdrawalRequestsResultModel> getWithdrawalRequests(
      lang, token, skip, take) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'skip': skip, r'take': take};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WithdrawalRequestsResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang,
                  r'token': token
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'Wallet/GetWithdrawalRequests',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WithdrawalRequestsResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> withdrawalRequest(
      lang, token, amount, description) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {'amount': amount, 'description': description};
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
            .compose(_dio.options, 'Wallet/WithdrawalRequest',
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

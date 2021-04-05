// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_wallet_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CustomerWalletRemoteDataSource
    implements CustomerWalletRemoteDataSource {
  _CustomerWalletRemoteDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://178.157.14.77/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<WalletInfoResultModel> getWalletInfo(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Wallet/GetWalletInfo',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = WalletInfoResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<WalletDetailResultModel> getWalletDetail(token, page) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Wallet/GetWalletDetail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = WalletDetailResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<WalletLoadBalanceResultModel> loadBalance(token, amount) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(amount, 'amount');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'amount': amount};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Wallet/LoadBalance',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = WalletLoadBalanceResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<WalletLoadBalanceResultModel> loadBalanceConfirmation(
      token, id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Id': id};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'customer/Wallet/LoadBalanceConfirmation',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{
              r'Content-Type': 'application/json',
              r'Accept': 'text/plain',
              r'token': token
            },
            extra: _extra,
            contentType: 'application/json',
            baseUrl: baseUrl),
        data: _data);
    final value = WalletLoadBalanceResultModel.fromJson(_result.data);
    return value;
  }
}

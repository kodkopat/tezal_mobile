// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthRemoteDataSource implements AuthRemoteDataSource {
  _AuthRemoteDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://178.157.14.77/api/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<RegisterResultModel> register(name, phone, pass) async {
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(phone, 'phone');
    ArgumentError.checkNotNull(pass, 'pass');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'name': name, 'phone': phone, 'pass': pass};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('User/Register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RegisterResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<CheckSmsResultModel> checkSms(id, sms) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(sms, 'sms');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'id': id, 'sms': sms};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('User/CheckSms',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CheckSmsResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginResultModel> login(username, password) async {
    ArgumentError.checkNotNull(username, 'username');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'username': username, 'password': password};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('User/Login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginResultModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<CheckTokenResultModel> checkToken(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'token': token};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('User/CheckToken',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CheckTokenResultModel.fromJson(_result.data);
    return value;
  }
}

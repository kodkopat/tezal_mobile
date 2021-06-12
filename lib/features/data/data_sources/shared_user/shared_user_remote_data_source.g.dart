// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_user_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SharedUserRemoteDataSource implements SharedUserRemoteDataSource {
  _SharedUserRemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://185.116.162.192/shared/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginResultModel> login(lang, username, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {'username': username, 'password': password};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/Login',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckTokenResultModel> checkToken(lang, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {'token': token};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckTokenResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/CheckToken',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckTokenResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterResultModel> register(lang, name, phone, pass) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {'Name': name, 'Phone': phone, 'Password': pass};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RegisterResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/Register',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckSmsResultModel> confirmRegistration(lang, id, sms) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {'id': id, 'sms': sms};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckSmsResultModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/ConfirmRegistration',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckSmsResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PhotoResultModel> getPhoto(lang, token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Token': token};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PhotoResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/GetPhoto',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PhotoResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> resetPasswordRequest(lang, phone) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'Phone': phone};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/ResetPasswordRequest',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseApiResultModel> resetPassword(
      lang, phone, sms, password, passwordRepeat) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'Phone': phone,
      r'sms': sms,
      r'Password': password,
      r'PasswordRepeat': passwordRepeat
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseApiResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/ResetPassword',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseApiResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AgreementResultModel> getPrivacyText(lang) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AgreementResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/getPrivacyText',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AgreementResultModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AgreementResultModel> getRulesText(lang) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AgreementResultModel>(Options(
                method: 'GET',
                headers: <String, dynamic>{
                  r'Content-Type': 'application/json',
                  r'Accept': 'text/plain',
                  r'lang': lang
                },
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, 'User/getRulesText',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AgreementResultModel.fromJson(_result.data!);
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

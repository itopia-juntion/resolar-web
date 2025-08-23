import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';

class ApiClient extends GetConnect {
  Future<RequestResult<bool>>? _loginFuture;
  String? _token;

  @override
  void onInit() {
    super.onInit();

    httpClient.baseUrl = "http://whereisit/";
    httpClient.timeout = const Duration(seconds: 15);
    httpClient.defaultContentType = 'application/json';

    httpClient.addRequestModifier<void>((request) {
      final path = request.url.path;
      final isAuthPath = path.contains('/auth/');

      if (!isAuthPath && _token != null) {
        request.headers['Authorization'] = 'Bearer $_token';
      }

      return request;
    });

    httpClient.addAuthenticator<void>((request) async {
      final path = request.url.path;
      if (path.contains('/auth/')) return request;

      await loginAndRefreshToken();
      if (_token == null || _token!.isEmpty) return request;

      request.headers['Authorization'] = 'Bearer $_token';
      return request;
    });

    httpClient.maxAuthRetries = 1;
  }

  Map<String, String> _cleanQuery(Map<String, dynamic> raw) {
    final m = <String, String>{};
    raw.forEach((k, v) {
      if (v != null) m[k] = "$v";
    });
    return m;
  }

  RequestResult<T> _wrap<T>(Response rp, T Function(Response rp)? map) {
    if (rp.isOk || rp.statusCode == 201 || rp.statusCode == 204) {
      try {
        if (T == EmptyBody) {
          return RequestSuccess<T>(EmptyBody() as T);
        }

        return RequestSuccess<T>(map!(rp));
      } catch (e) {
        if (kDebugMode) rethrow;
        return RequestFail('서버의 응답을 처리하지 못했어요.');
      }
    }
    return RequestFail('서버가 올바르지 않은 응답을 함 : ${rp.statusCode}');
  }

  Future<RequestResult<T>> _send<T>(
    Future<Response> Function() reqFn, {
    T Function(Response rp)? map,
  }) async {
    try {
      final rp = await reqFn();
      return _wrap<T>(rp, map);
    } on TimeoutException {
      return RequestFail('요청 시간이 초과되었습니다.');
    } on SocketException {
      return RequestFail('네트워크 연결을 확인해 주세요.');
    } catch (e) {
      if (kDebugMode) rethrow;
      return RequestFail('알 수 없는 오류가 발생했어요.');
    }
  }

  Future<RequestResult<bool>> loginAndRefreshToken() {
    if (_loginFuture != null) {
      return _loginFuture!;
    }

    var future = Future<RequestResult<bool>>(() async {
      return await _send(
        () async => await post(
          '/auth/login',
          "Imagine this!",
        ), // TODO : you know what to do
        map: (rp) {
          return true; // Maybe?
        },
      );
    }).whenComplete(() => _loginFuture = null);

    _loginFuture = future;
    return future;
  }
}

sealed class RequestResult<T> {}

class RequestSuccess<T> extends RequestResult<T> {
  final T data;

  RequestSuccess(this.data);
}

class RequestFail extends RequestResult<Never> {
  final String reason;

  RequestFail(this.reason);
}

class EmptyBody {}

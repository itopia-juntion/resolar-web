import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resolar_web/app/models/subject.dart';
import 'package:resolar_web/app/models/web_page.dart';
import 'package:resolar_web/app/services/auth_service.dart';

class ApiClient extends GetConnect {
  Future<RequestResult<EmptyBody>>? _loginFuture;
  AuthService get authService => Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();

    httpClient.baseUrl = "https://c614105eedfe.ngrok-free.app/api";
    httpClient.timeout = const Duration(seconds: 15);
    httpClient.defaultContentType = 'application/json';

    httpClient.addRequestModifier<void>((request) {
      final path = request.url.path;
      request.headers['ngrok-skip-browser-warning'] = "${true}";
      final isAuthPath = path.contains('/auth/');

      var token = authService.accessToken;

      if (!isAuthPath && token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      return request;
    });
  }

  Map<String, String> _cleanQuery(Map<String, dynamic> raw) {
    final m = <String, String>{};
    raw.forEach((k, v) {
      if (v != null) m[k] = "$v";
    });
    return m;
  }

  RequestResult<T> _wrap<T>(Response rp, T Function(Response rp) map) {
    if (rp.isOk || rp.statusCode == 201 || rp.statusCode == 204) {
      try {
        return RequestSuccess<T>(map(rp));
      } catch (e) {
        if (kDebugMode) rethrow;
        return RequestFail('서버의 응답을 처리하지 못했어요.');
      }
    }
    return RequestFail('작업을 완료할 수 없습니다 : ${rp.statusCode}');
  }

  Future<RequestResult<T>> _send<T>(
    Future<Response> Function() reqFn, {
    required T Function(Response rp) map,
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

  Future<RequestResult<EmptyBody>> loginAndRefreshToken(
    String username,
    String password,
  ) {
    if (_loginFuture != null) {
      return _loginFuture!;
    }

    var future = Future<RequestResult<EmptyBody>>(() async {
      return await _send(
        () async => await post(
          '/auth/login', //흐흐 주소 맞췄다!!
          _cleanQuery({'username': username, 'password': password}),
        ),
        map: (rp) {
          String? token = json.decode(rp.bodyString!)['accessToken'];
          authService.updateAccessToken(token ?? '');
          return EmptyBody();
        },
      );
    }).whenComplete(() => _loginFuture = null);

    _loginFuture = future;
    return future;
  }

  Future<RequestResult<EmptyBody>> signUpAndRefreshToken(
    String username,
    String password,
    String email,
  ) async {
    return await _send(
      () async => await post(
        '/auth/join',
        _cleanQuery({
          'username': username.trim(),
          'password': password.trim(),
          'email': email.trim(),
        }),
      ),
      map: (rp) {
        String? token = json.decode(rp.bodyString!)['accessToken'];
        authService.updateAccessToken(token ?? '');
        return EmptyBody();
      },
    );
  }

  Future<RequestResult<List<Subject>>> getSubjects() async {
    return await _send(
      () async => await get('/subjects'),
      map: (rp) {
        List items = json.decode(rp.bodyString!);
        List<Subject> subjects = [];

        for (var item in items) {
          subjects.add(Subject.fromJson(item));
        }

        return subjects;
      },
    );
  }

  Future<RequestResult<EmptyBody>> createSubject(String name) async {
    return await _send(
      () async => await post('/subjects', {'name': name}),
      map: (rp) {
        return EmptyBody();
      },
    );
  }

  Future<RequestResult<EmptyBody>> deleteSubject(int subjectId) async {
    return await _send(
      () async => await delete('/subjects/$subjectId'),
      map: (rp) {
        return EmptyBody();
      },
    );
  }

  Future<RequestResult<List<WebPage>>> getPages(int subjectId) async {
    return await _send(
      () async =>
          await get('/pages', query: {'subjectId': subjectId.toString()}),
      map: (rp) {
        List items = json.decode(rp.bodyString!);
        List<WebPage> pages = [];

        for (var item in items) {
          pages.add(WebPage.fromJson(item));
        }

        return pages;
      },
    );
  }

  Future<RequestResult<List<WebPage>>> searchPages(
    String keyword,
    int subjectId,
  ) async {
    return await _send(
      () async => await get(
        '/pages/search',
        query: {'keyword': keyword, 'subjectId': subjectId.toString()},
      ),
      map: (rp) {
        List items = json.decode(rp.bodyString!);
        List<WebPage> pages = [];

        for (var item in items) {
          pages.add(WebPage.fromJson(item));
        }

        return pages;
      },
    );
  }

  Future<RequestResult<WebPage?>> searchAi(
    String keyword,
    int subjectId,
  ) async {
    return await _send(
      () async => await get(
        '/subjects/search',
        query: {'keyword': keyword, 'subjectId': subjectId.toString()},
      ),
      map: (rp) {
        String body = rp.bodyString!;
        if (body.contains('없습니다.",')) return null;
        var item = json.decode(body);
        return WebPage.fromJson(item);
      },
    );
  }

  Future<RequestResult<Uint8List>> getSubjectSummary(int subjectId) async {
    try {
      final token = authService.accessToken;
      final uri = Uri.parse(
        '${httpClient.baseUrl}/subjects/summary/$subjectId',
      );

      final headers = <String, String>{
        'ngrok-skip-browser-warning': 'true',
        'Accept': 'application/octet-stream',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final rp = await http
          .post(uri, headers: headers, body: jsonEncode({}))
          .timeout(httpClient.timeout);

      if (rp.statusCode == 200 ||
          rp.statusCode == 201 ||
          rp.statusCode == 204) {
        // rp.bodyBytes is already a Uint8List
        return RequestSuccess<Uint8List>(rp.bodyBytes);
      }

      return RequestFail('작업을 완료할 수 없습니다 : ${rp.statusCode}');
    } on TimeoutException {
      return RequestFail('요청 시간이 초과되었습니다.');
    } on SocketException {
      return RequestFail('네트워크 연결을 확인해 주세요.');
    } catch (e) {
      if (kDebugMode) rethrow;
      return RequestFail('알 수 없는 오류가 발생했어요.');
    }
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

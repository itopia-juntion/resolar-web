// To parse this JSON data, do
//
//     final webPage = webPageFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_page.freezed.dart';
part 'web_page.g.dart';

WebPage webPageFromJson(String str) => WebPage.fromJson(json.decode(str));

String webPageToJson(WebPage data) => json.encode(data.toJson());

@freezed
abstract class WebPage with _$WebPage {
  const factory WebPage({
    required int id,
    required String url,
    @Default('') String title,
    required String summary,
    required int importance,
    required int subjectId,
  }) = _WebPage;

  factory WebPage.fromJson(Map<String, dynamic> json) =>
      _$WebPageFromJson(json);
}

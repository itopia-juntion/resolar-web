// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject.freezed.dart';
part 'subject.g.dart';

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));

String subjectToJson(Subject data) => json.encode(data.toJson());

@freezed
abstract class Subject with _$Subject {
  const factory Subject({required int id, required String name}) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}

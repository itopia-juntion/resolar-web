// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebPage _$WebPageFromJson(Map<String, dynamic> json) => _WebPage(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  title: json['title'] as String? ?? '',
  summary: json['summary'] as String,
  importance: (json['importance'] as num).toInt(),
  subjectId: (json['subjectId'] as num).toInt(),
);

Map<String, dynamic> _$WebPageToJson(_WebPage instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'title': instance.title,
  'summary': instance.summary,
  'importance': instance.importance,
  'subjectId': instance.subjectId,
};
